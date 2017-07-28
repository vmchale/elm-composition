module Data.Composition exposing (..)

{-| Data.Composition essentially ports Haskell's [composition](https://hackage.haskell.org/package/composition-1.0.2.1/docs/Data-Composition.html) package to Elm.


# Common combinators

@docs (.*)

-}


{-| See type signature
-}
(.*) : (c -> d) -> (a -> b -> c) -> a -> b -> d
(.*) f g x y =
    f (g x y)
infixr 9 .*
