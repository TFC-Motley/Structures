import Int "Int";
import BaseLib "mo:base/Int8";
import Binary "mo:encoding/Binary";
import Struct "../Struct";
import Tag "../Tags";

module {

  type Struct = Struct.Struct;
  
  type Tag = Struct.Tag;
  type Length = Struct.Length;
  type Value = Struct.Value;
  
  public func tag() : Tag { Tag.int8 };

  public func valid( s : Struct ) : Bool {
    if ( Struct.Tag.notEqual(s, Tag.int8) ) false
    else Struct.Value.length(s) == 2
  };

  public func toStruct( int8 : Int8 ) : Struct {
    let flag : Nat8 = if ( int8 < 0 ) 1 else 0;
    let bytes : [Nat8] = [flag, BaseLib.toNat8(int8)];
    Struct.build(?Tag.int8, ?2, ?#array( bytes ))
  };

  public func fromStruct( s : Struct ) : ?Int8 {
    if ( Struct.Tag.notEqual(s, Tag.int8) ) return null;
    if ( Struct.Value.length( s ) != 2 ) Struct.trap("Incorrect length for Type<Int8>");
    let ret : Int8 = BaseLib.fromNat8( Struct.Value.toArray(s)[1] );
    if ( Struct.Value.toArray(s)[0] == 1 ) ?BaseLib.neg(ret)
    else ?ret
  }

};