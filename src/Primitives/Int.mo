import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Blob "mo:base/Blob";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import BaseLib "mo:base/Int";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.int };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.int ) ) false
    else Struct.Value.length(s) > 0
  };

  public func toStruct( int : Int ) : Struct {
    let nat : Nat = BaseLib.abs( int );
    let flag : Nat8 = if ( int < 0 ) 1 else 0;
    let (size, value) : (Nat, [Nat8]) = 
      if ( int <= 255 ) wrap_signed_value(flag, nat, #n8)
      else if ( int <= 65535 ) wrap_signed_value(flag, nat, #n16)
      else if ( nat <= 4294967295 ) wrap_signed_value(flag, nat, #n32)
      else if ( nat <= 9223372036854775807 ) wrap_signed_value(flag, nat, #n64)
      else {
        let blob : Blob = Text.encodeUtf8( Nat.toText( nat ) );
        (blob.size(), Blob.toArray(blob))
      };
    Struct.build(?Tag.int, ?Nat32.fromNat(size), ?#array( value ))
  };

  public func fromStruct( s : Struct ) : ?Int {
    if ( Struct.Tag.notEqual(s, Tag.int) ) return null;
    if ( Struct.Value.length( s ) == 0 ) Struct.trap("Value field can't be empty for Type<Int>"); 
    let bytes : [Nat8] = Struct.Value.toArray( s );
    if ( Struct.Value.length(s) == 2 ) ?unwrap_signed_value(bytes, 1)
    else if ( Struct.Value.length(s) == 3 ) ?unwrap_signed_value(bytes, 2)
    else if ( Struct.Value.length(s) == 5 ) ?unwrap_signed_value(bytes, 4)
    else if ( Struct.Value.length(s) == 9 ) ?unwrap_signed_value(bytes, 8)
    else {
      let opt : ?Text = Text.decodeUtf8( Blob.fromArray(bytes) );
      if ( Option.isNull(opt) ) return null;
      text_to_nat( Option.get<Text>(opt, "") );
    }
  };

  public func wrap_signed_value( flag : Nat8, val : Nat, opt : { #n8; #n16; #n32; #n64 } ) : (Nat, [Nat8]) {
    let (size, bytes) = switch opt {
      case ( #n8  ) (1, [Nat8.fromNat( val)]);
      case ( #n16 ) (2, Binary.BigEndian.fromNat16( Nat16.fromNat( val ) ));
      case ( #n32 ) (4, Binary.BigEndian.fromNat32( Nat32.fromNat( val ) ));
      case ( #n64 ) (8, Binary.BigEndian.fromNat64( Nat64.fromNat( val ) ));
    };
    var idx : Nat = 0;
    let resp = Array.init<Nat8>(size+1, flag);
    label l loop {
      if ( idx >= size ) break l;
      resp[idx+1] := bytes[idx];
      idx += 1
    };
    (size+1, Array.freeze<Nat8>( resp ))
  };

  public func unwrap_signed_value( b : [Nat8], size : Nat ) : Int {
    var idx : Nat = 0;
    let neg : Bool = if ( b[idx] == 1) true else false;
    let value : [var Nat8] = Array.init<Nat8>(size, 0);
    label l loop {
      if ( idx >= size ) break l;
      value[idx] := b[idx+1];
      idx += 1;
    };
    let nat : Nat = 
      if ( size == 1 ) Nat8.toNat( value[0] )
      else if ( size == 2 ) Nat16.toNat( Binary.BigEndian.toNat16( Array.freeze<Nat8>( value ) ) )
      else if ( size == 4 ) Nat32.toNat( Binary.BigEndian.toNat32( Array.freeze<Nat8>( value ) ) )
      else Nat64.toNat( Binary.BigEndian.toNat64( Array.freeze<Nat8>( value ) ) );
    if neg BaseLib.neg( nat )
    else nat
  };

  func text_to_nat( txt : Text) : ?Nat {
    let chars = txt.chars();
    var num : Nat = 0;
    for (v in chars){
      let charToNum = Nat32.toNat(Char.toNat32(v)-48);
      if (charToNum >= 0 and charToNum <= 9) num := num * 10 +  charToNum
      else return null;          
    };
    ?num;
  };

};