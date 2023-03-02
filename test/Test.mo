import M "mo:matchers/Matchers";
import S "mo:matchers/Suite";
import T "mo:matchers/Testable";
import Struct "../src/Struct";
import Principal "mo:base/Principal";
import PrincipalStruct "../src/Primitives/Principal";
import Int16Struct "../src/Primitives/Int16";
import Int32Struct "../src/Primitives/Int32";
import Int64Struct "../src/Primitives/Int64";
import NatStruct "../src/Primitives/Nat";
import Nat8Struct "../src/Primitives/Nat8";
import Nat16Struct "../src/Primitives/Nat16";
import Nat32Struct "../src/Primitives/Nat32";
import Nat64Struct "../src/Primitives/Nat64";
import TextStruct "../src/Primitives/Text";
import BlobStruct "../src/Primitives/Blob";
import BoolStruct "../src/Primitives/Bool";
import IntStruct "../src/Primitives/Int";
import Int8Struct "../src/Primitives/Int8";

type Struct = Struct.Struct;

func blobTest( x : Blob ) : Bool {
  let temp : Struct = BlobStruct.toStruct( x );
  if ( not BlobStruct.valid( temp ) ) return false;
  switch( BlobStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func boolTest( x : Bool ) : Bool {
  let temp : Struct = BoolStruct.toStruct( x );
  if ( not BoolStruct.valid( temp ) ) return false;
  switch( BoolStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func intTest( x : Int ) : Bool {
  let temp : Struct = IntStruct.toStruct( x );
  if ( not IntStruct.valid( temp ) ) return false;
  switch( IntStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func int8Test( x : Int8 ) : Bool {
  let temp : Struct = Int8Struct.toStruct( x );
  if ( not Int8Struct.valid( temp ) ) return false;
  switch( Int8Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func int16Test( x : Int16 ) : Bool {
  let temp : Struct = Int16Struct.toStruct( x );
  if ( not Int16Struct.valid( temp ) ) return false;
  switch( Int16Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func int32Test( x : Int32 ) : Bool {
  let temp : Struct = Int32Struct.toStruct( x );
  if ( not Int32Struct.valid( temp ) ) return false;
  switch( Int32Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func int64Test( x : Int64 ) : Bool {
  let temp : Struct = Int64Struct.toStruct( x );
  if ( not Int64Struct.valid( temp ) ) return false;
  switch( Int64Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func natTest( x : Nat ) : Bool {
  let temp : Struct = NatStruct.toStruct( x );
  if ( not NatStruct.valid( temp ) ) return false;
  switch( NatStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func nat8Test( x : Nat8 ) : Bool {
  let temp : Struct = Nat8Struct.toStruct( x );
  if ( not Nat8Struct.valid( temp ) ) return false;
  switch( Nat8Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func nat16Test( x : Nat16 ) : Bool {
  let temp : Struct = Nat16Struct.toStruct( x );
  if ( not Nat16Struct.valid( temp ) ) return false;
  switch( Nat16Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func nat32Test( x : Nat32 ) : Bool {
  let temp : Struct = Nat32Struct.toStruct( x );
  if ( not Nat32Struct.valid( temp ) ) return false;
  switch( Nat32Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func nat64Test( x : Nat64 ) : Bool {
  let temp : Struct = Nat64Struct.toStruct( x );
  if ( not Nat64Struct.valid( temp ) ) return false;
  switch( Nat64Struct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func principalTest( x : Principal ) : Bool {
  let temp : Struct = PrincipalStruct.toStruct( x );
  if ( not PrincipalStruct.valid( temp ) ) return false;
  switch( PrincipalStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};
func textTest( x : Text ) : Bool {
  let temp : Struct = TextStruct.toStruct( x );
  if ( not TextStruct.valid( temp ) ) return false;
  switch( TextStruct.fromStruct( temp ) ){
    case null false;
    case ( ?y ) x == y;
  }
};

let suite = S.suite("Structures", [
    S.test("Blob Constructs & Deconstructs", 
      blobTest( "\0A\01\AB\CD\EF\FE\DC\BA" ),
      M.equals(T.bool(true))),
    S.test("Bool Constructs & Deconstructs",
      boolTest(true),
      M.equals(T.bool(true))),
    S.test("Int Constructs & Deconstructs",
      intTest( -235 ),
      M.equals(T.bool(true))),
    S.test("Int8 Constructs & Deconstructs",
      int8Test( 116 ),
      M.equals(T.bool(true))),
    S.test("Int18 Constructs & Deconstructs",
      int16Test( -235 ),
      M.equals(T.bool(true))),
    S.test("Int32 Constructs & Deconstructs",
      int32Test( 124467 ),
      M.equals(T.bool(true))),
    S.test("Int64 Constructs & Deconstructs",
      int64Test( -124467121 ),
      M.equals(T.bool(true))),
    S.test("Nat Constructs & Deconstructs",
      natTest( 124467 ),
      M.equals(T.bool(true))),
    S.test("Nat8 Constructs & Deconstructs",
      nat8Test( 235 ),
      M.equals(T.bool(true))),
    S.test("Nat16 Constructs & Deconstructs",
      nat16Test( 12345 ),
      M.equals(T.bool(true))),
    S.test("Nat32 Constructs & Deconstructs",
      nat32Test( 123456477 ),
      M.equals(T.bool(true))),
    S.test("Nat64 Constructs & Deconstructs",
      nat64Test( 123192571 ),
      M.equals(T.bool(true))),
    S.test("Principal Constructs & Deconstructs",
      principalTest( Principal.fromText("aaaaa-aa") ),
      M.equals(T.bool(true))),
    S.test("Text Constructs & Deconstructs",
      textTest( "Crabapple" ),
      M.equals(T.bool(true))),
]);

S.run(suite);
