let upstream =
    https://github.com/dfinity/vessel-package-set/releases/download/mo-0.7.6-20230120/package-set.dhall

let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let additions = [
  { name = "base"
  , repo = "https://github.com/dfinity/motoko-base"
  , version = "moc-0.7.6" -- Motoko 0.7.3
  , dependencies = [] : List Text
  },
  { name = "base-0.7.3"
  , repo = "https://github.com/dfinity/motoko-base"
  , version = "aafcdee0c8328087aeed506e64aa2ff4ed329b47"
  , dependencies = [] : List Text
  },
  { name = "stableRBT"
  , repo = "https://github.com/canscale/StableRBTree"
  , version = "v0.6.0"
  , dependencies = [] : List Text
  },
  { name = "stableBuffer"
  , repo = "https://github.com/canscale/StableBuffer"
  , version = "v0.2.0"
  , dependencies = [] : List Text
  },
  { name = "encoding"
  , repo = "https://github.com/aviate-labs/encoding.mo"
  , version = "v0.4.1"
  , dependencies = [] : List Text
  },
  { name = "crypto"
  , repo = "https://github.com/aviate-labs/crypto.mo"
  , version = "v0.3.1"
  , dependencies = [] : List Text
  },] : List Package

in  upstream # additions