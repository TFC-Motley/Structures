import I "Int";
import Int "mo:base/Int";
import BaseLib "mo:base/Int64";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.int64 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.int64) ) false
    else Struct.Value.length(s) == 9
  };

  public func toStruct( int64 : Int64 ) : Struct {
    let flag : Nat8 = if ( int64 < 0 ) 1 else 0;
    let nat : Nat = Int.abs( BaseLib.toInt( int64 ) );
    let (_, value) =  I.wrap_signed_value(flag, nat, #n64);
    Struct.build(?Tag.int64, ?9, ?#array( value ))
  };

  public func fromStruct( s : Struct ) : ?Int64 {
    if ( Struct.Tag.notEqual(s, Tag.int64) ) return null;
    if ( Struct.Value.length( s ) != 9 ) Struct.trap("Incorrect length for Type<Int64>");
    ?BaseLib.fromInt( I.unwrap_signed_value(Struct.Value.toArray(s), 8) );
  }

};