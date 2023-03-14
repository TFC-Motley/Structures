import BaseLib "mo:base/Nat64";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.nat64 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.nat64) ) false
    else Struct.Value.length(s) == 8
  };

  public func toStruct( nat64 : Nat64 ) : Struct {
    Struct.build(?Tag.nat64, ?8, ?#array( Binary.BigEndian.fromNat64( nat64 ) ))
  };

  public func fromStruct( s : Struct ) : ?Nat64 {
    if ( Struct.Tag.notEqual(s, Tag.nat64) ) return null;
    if ( Struct.Value.length( s ) != 8 ) Struct.trap("Incorrect length for Type<Nat64>");
    ?Binary.BigEndian.toNat64( Struct.Value.toArray(s) );
  }

};