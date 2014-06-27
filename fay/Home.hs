{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE EmptyDataDecls    #-}
module Home where

import Fay.FFI
import Language.Fay.Yesod
import Prelude
import SharedTypes

data Element

getElementById :: String -> Fay Element
getElementById = ffi "document.getElementById(%1)"

getAttribute :: String -> Element -> Fay String
getAttribute = ffi "%2[%1]"

setInnerHTML :: Element -> String -> Fay ()
setInnerHTML = ffi "%1.innerHTML=%2"

onKeyUp :: Element -> Fay () -> Fay ()
onKeyUp = ffi "%1.onkeyup=%2"

alert :: String -> Fay ()
alert = ffi "window.alert(%1)"

parseInt :: String -> Fay Int
parseInt = ffi "window.parseInt(%1, 10)"

main :: Fay ()
main = do
    fayin <- getElementById "fayin"
    jsout <- getElementById "jsout"

    onKeyUp fayin $ do
        fayCode <- getAttribute "value" fayin
        call (CompileFay fayCode) $ \x ->
            case x of
                Nothing -> setInnerHTML jsout "Failed to compile"
                Just text -> setInnerHTML jsout text


    input <- getElementById "fibindex"
    result <- getElementById "fibresult"
    onKeyUp input $ do
        indexS <- getAttribute "value" input
        index <- parseInt indexS
        call (GetFib index) $ setInnerHTML result . show
