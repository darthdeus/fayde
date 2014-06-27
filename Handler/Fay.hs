module Handler.Fay where

import Import
import Yesod.Fay
import Fay.Convert (readFromFay)

fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)

onCommand :: CommandHandler App
onCommand render command =
    case readFromFay command of
      Just (GetFib index r) -> render r $ fibs !! index
      Just (CompileFay input r) -> render r $ Just "sending this to fay"
      Nothing               -> invalidArgs ["Invalid command"]
