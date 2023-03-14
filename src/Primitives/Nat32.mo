import BaseLib "mo:base/Nat32";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.nat32 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.nat32) ) false
    else Struct.Value.length(s) == 4
  };

  public func toStruct( nat32 : Nat32 ) : Struct {
    Struct.build(?Tag.nat32, ?4, ?#array( Binary.BigEndian.fromNat32( nat32 ) ))
  };

  public func fromStruct( s : Struct ) : ?Nat32 {
    if ( Struct.Tag.notEqual(s, Tag.nat32) ) return null;
    if ( Struct.Value.length( s ) != 4 ) Struct.trap("Incorrect length for Type<Nat32>");
    ?Binary.BigEndian.toNat32( Struct.Value.toArray(s) );
  }

};