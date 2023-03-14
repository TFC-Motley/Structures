import Nat32 "mo:base/Nat32";
import BaseLib "mo:base/Bool";
import Option "mo:base/Option";
import Struct "../Struct";
import Tag "../Tags";
import Debug "mo:base/Debug";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.bool };

  public func valid( s : Struct ) : Bool { 
    if ( Struct.Tag.notEqual(s, Tag.bool ) ) false
    else Struct.Value.length(s) == 1
  };

  public func toStruct( bool : Bool ) : Struct {
    Debug.print("Bool");
    let value : Nat8 = if bool 1 else 0;
    Struct.build(?Tag.bool, ?Nat32.fromNat(1), ?#array( [value] ))
  };

  public func fromStruct( s : Struct ) : ?Bool {
    if ( Struct.Tag.notEqual(s, Tag.bool) ) return null;
    if ( Struct.Value.length(s) != 1 ) Struct.trap("Length of Type<Bool> must equal 1");
    let value : Nat8 = Struct.Value.toArray(s)[0];
    if ( value > 1 ) Struct.trap("Value of Type<Bool> must be <= 1");
    if ( value == 1 ) ?true
    else ?false;
  }

};
