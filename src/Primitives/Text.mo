import Nat32 "mo:base/Nat32";
import BaseLib "mo:base/Text";
import Option "mo:base/Option";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;

  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.text };

  public func valid( s : Struct ) : Bool { Struct.Tag.equal(s, Tag.text) };

  public func toStruct( t : Text ) : Struct {
    Struct.build(?Tag.text, ?Nat32.fromNat(t.size()), ?#blob( BaseLib.encodeUtf8(t) ))
  };

  public func fromStruct( s : Struct ) : ?Text {
    if ( Struct.Tag.notEqual(s, Tag.text) ) return null;
    BaseLib.decodeUtf8( Struct.Value.raw(s) );
  };

};