import Binary "mo:encoding/Binary";
import Blob "mo:base/Blob";
import Iter "mo:base/Iter";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Option "mo:base/Option";
import T "Tags";

module Struct = {

  public type Struct = (Tag, Length, Value);

  public type Tag = Nat8;
  public type Length = Nat32;
  public type Value = Blob;

  public type Pattern = {
    #varArray : [var Nat8];
    #array : [Nat8];
    #blob : Blob;
    #iter : Iter.Iter<Nat8>;
  };

  public module Tag = {

    public func raw( struct : Struct ) : Nat8 { struct.0 };
  
    public func set( struct : Struct, tag : Tag ) : Struct { (tag, struct.1, struct.2) };

    public func equal( struct : Struct, tag : Tag ) : Bool { struct.0 == tag };

    public func notEqual( struct : Struct, tag : Tag ) : Bool { struct.0 != tag };

    public func toArray( struct : Struct ) : [Nat8] { [struct.0] };

    public func toVarArray( struct : Struct ) : [var Nat8] { [var struct.0] };

  };

  public module Length = {

    public let empty : Nat32 = 0x00000000;

    public func raw( struct : Struct ) : Nat32 { struct.1 };

    public func set( struct : Struct, md : Length ) : Struct { (struct.0, md, struct.2) };

    public func equal( struct : Struct, n : Nat32 ) : Bool { struct.1 == n };

    public func notEqual( struct : Struct, n : Nat32 ) : Bool { struct.1 != n }; 

    public func toArray( struct : Struct ) : [Nat8] {
      Binary.BigEndian.fromNat32( struct.1 )
    };
    public func toVarArray( struct : Struct ) : [var Nat8] {
      Array.thaw<Nat8>( Binary.BigEndian.fromNat32( struct.1 ) )
    };

  };

  public module Value = {

    public func raw( struct : Struct ) : Blob { struct.2 };

    public func length( struct : Struct ) : Nat { Nat32.toNat(struct.1) };

    public func convert<T>( struct : Struct, fn : Blob -> T ) : T { fn( struct.2 ) };

    public func toArray( struct : Struct ) : [ Nat8 ] { Blob.toArray( struct.2 ) };

    public func toVarArray( struct : Struct ) : [ var Nat8 ] { Blob.toArrayMut( struct.2 ) };

    public func compare( sx : Struct, sy : Struct ) : {#less; #equal; #greater} {
      Blob.compare( sx.2, sy.2 )
    };

    public func set( struct : Struct, val : Pattern ) : Struct {
      switch val {
        case ( #varArray b ) (struct.0, struct.1, Blob.fromArrayMut( b ));
        case ( #array b ) (struct.0, struct.1, Blob.fromArray( b ));
        case ( #iter b ) (struct.0, struct.1, Blob.fromArray(Iter.toArray<Nat8>(b)));
        case ( #blob b ) (struct.0, struct.1, b);
      }
    };

  };

  public func empty() : Struct { build(null, null, null) };

  public func trap( _type : Text ) : () { Debug.trap("Faulty Structure: " # _type) };

  public func length( struct : Struct ) : Nat { Value.length(struct) + 8 };

  public func equal( sx : Struct, sy : Struct ) : Bool {
    sx.0 == sy.0 and sx.1 == sy.1 and sx.2 == sy.2
  };

  public func notEqual( sx : Struct, sy : Struct ) : Bool {
    sx.0 != sy.0 or sx.1 != sy.1 or sx.2 != sy.2
  };

  public func build( _tag : ?Tag, _len : ?Length, _val : ?Pattern ) : Struct {
    let t : Tag = Option.get<Tag>(_tag, T.null_);
    let l : Length = Option.get<Length>(_len, Length.empty);
    let p : Pattern = Option.get<Pattern>(_val, #blob(""));
    let v : Value = switch( p ){
      case ( #varArray b ) Blob.fromArrayMut( b );
      case ( #array b ) Blob.fromArray( b );
      case ( #iter b ) Blob.fromArray(Iter.toArray<Nat8>(b));
      case ( #blob b ) b 
    };
    (t,l,v)
  };

}