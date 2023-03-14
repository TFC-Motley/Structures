import I "Int";
import Int "mo:base/Int";
import BaseLib "mo:base/Int16";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.int16 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.int16) ) false
    else Struct.Value.length(s) == 3
  };

  public func toStruct( int16 : Int16 ) : Struct {
    let flag : Nat8 = if ( int16 < 0 ) 1 else 0;
    let nat : Nat = Int.abs( BaseLib.toInt( int16 ) );
    let (_, value) =  I.wrap_signed_value(flag, nat, #n16);
    Struct.build(?Tag.int16, ?3, ?#array( value ))
  };

  public func fromStruct( s : Struct ) : ?Int16 {
    if ( Struct.Tag.notEqual(s, Tag.int16) ) return null;
    if ( Struct.Value.length( s ) != 3 ) Struct.trap("Incorrect length for Type<Int16>");
    ?BaseLib.fromInt( I.unwrap_signed_value(Struct.Value.toArray(s), 2) );
  }

};