import Nat32 "mo:base/Nat32";
import BaseLib "mo:base/Blob";
import Option "mo:base/Option";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.blob };

  public func valid( s : Struct ) : Bool { Struct.Tag.equal(s, Tag.blob ) };

  public func toStruct( blob : Blob ) : Struct {
    Struct.build(?Tag.blob, ?Nat32.fromNat(blob.size()), ?#blob( blob ))
  };

  public func fromStruct( s : Struct ) : ?Blob {
    if ( Struct.Tag.notEqual(s, Tag.blob) ) return null;
    ?Struct.Value.raw(s);
  }

};