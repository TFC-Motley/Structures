import BaseLib "mo:base/Nat8";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.nat8 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.nat8) ) false
    else Struct.Value.length(s) == 1
  };

  public func toStruct( nat8 : Nat8 ) : Struct {
    Struct.build(?Tag.nat8, ?1, ?#array( [nat8] ))
  };

  public func fromStruct( s : Struct ) : ?Nat8 {
    if ( Struct.Tag.notEqual(s, Tag.nat8) ) return null;
    if ( Struct.Value.length( s ) != 1 ) Struct.trap("Incorrect length for Type<Nat8>");
    ?Struct.Value.toArray(s)[0];
  }

};