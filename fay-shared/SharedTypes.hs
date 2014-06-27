{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import Prelude
import Data.Data
import Language.Fay.Yesod
#ifdef FAY
import FFI
#else
--import Language.Fay.FFI
#endif

data Command = GetFib Int (Returns Int)
             | CompileFay String (Returns (Maybe String))
    deriving (Read, Typeable, Data)
