import Nat32 "mo:base/Nat32";
import BaseLib "mo:base/Principal";
import Option "mo:base/Option";
import Struct "../Struct";
import Tag "../Tags";
import Debug "mo:base/Debug";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.principal };

  public func valid( s : Struct ) : Bool { Struct.Tag.equal(s, Tag.principal) };

  public func toStruct( p : Principal ) : Struct {
    Debug.print("Principal");
    let value : Blob = BaseLib.toBlob( p );
    Struct.build(?Tag.principal, ?Nat32.fromNat(value.size()), ?#blob( value ))
  };

  public func fromStruct( s : Struct ) : ?Principal {
    if ( Struct.Tag.notEqual(s, Tag.principal) ) return null;
    // if ( Struct.Value.length(s) == 0 ) Struct.trap("Length of Type<Principal> can't be 0");
    ?BaseLib.fromBlob( Struct.Value.raw(s) );
  }

};
