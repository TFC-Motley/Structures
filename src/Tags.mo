module {

  /// The first 32 tag values [ 0 - 31 ] are reserved globally
  ///
  /// Application specific tags should be >= 32
  ///
  public let blob : Nat8 = 1;
  public let bool : Nat8 = 2;
  public let int : Nat8 = 3;
  public let int8 : Nat8 = 4;
  public let int16 : Nat8 = 5;
  public let int32 : Nat8 = 6;
  public let int64 : Nat8 = 7;
  public let nat : Nat8 = 8;
  public let nat8 : Nat8 = 9;
  public let nat16 : Nat8 = 10;
  public let nat32 : Nat8 = 11;
  public let nat64 : Nat8 = 12;
  public let text : Nat8 = 13;
  public let principal : Nat8 = 14;
  public let array : Nat8 = 15;
  public let record : Nat8 = 16;
  public let tuple : Nat8 = 17;
  public let option : Nat8 = 18;
  public let null_ : Nat8 = 0;

};