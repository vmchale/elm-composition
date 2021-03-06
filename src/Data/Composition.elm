module Data.Composition exposing (..)

{-| Data.Composition essentially ports Haskell's [composition](https://hackage.haskell.org/package/composition-1.0.2.1/docs/Data-Composition.html) package to Elm.

#Convencience functions

@docs (.)

@docs ($)

@docs const


# Common combinators

@docs (.*)

@docs (.**)

@docs (.***)

@docs on

@docs (&)

@docs (-$)

@docs (-.*)


# Arrows

@docs (&&&)

@docs (***)

@docs first

@docs second

-}


{-| This is provided for people familiar with Haskell/Idris' composition operator, though it is not any different from '<<'
-}
(.) : (b -> c) -> (a -> b) -> a -> c
(.) f g =
    f << g
infixr 9 .


{-| See type signature
-}
(&) : a -> (a -> b) -> b
(&) x f =
    f x
infixl 1 &


{-| Return a constant
-}
const : a -> (b -> a)
const x =
    \y -> x


{-| Precompose both inputs to a binary operator with some function
-}
on : (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f a b =
    op (f a) (f b)


{-| See type signature
-}
($) : (a -> b) -> a -> b
($) f x =
    f x
infixr 0 $


{-| See type signature
-}
(-$) : (a -> b -> c) -> a -> b -> c
(-$) f x y =
    f x y
infixr 0 -$


{-| See type signature
-}
(.*) : (c -> d) -> (a -> b -> c) -> a -> b -> d
(.*) f g x y =
    f (g x y)
infixr 9 .*


{-| Oedipus combinator
-}
(-.*) : (b -> c) -> (a -> c -> d) -> a -> b -> d
(-.*) f g x y =
    g x (f y)
infixr 9 -.*


{-| See type signature
-}
(.**) : (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
(.**) f g x y z =
    f (g x y z)
infixr 9 .**


{-| See type signature
-}
(.***) : (e -> f) -> (a -> b -> c -> d -> e) -> a -> b -> c -> d -> f
(.***) f g w x y z =
    f (g w x y z)
infixr 9 .***


{-| Combinator for arrows; essentially a limited form of what was proposed in John Hughes' *Generalising Monads to Arrows*
-}
(&&&) : (b -> c) -> (b -> d) -> b -> ( c, d )
(&&&) f g x =
    ( f x, g x )
infixr 3 &&&


{-| Another arrow combinator
-}
(***) : (b -> c) -> (d -> e) -> ( b, d ) -> ( c, e )
(***) f g ( y, z ) =
    ( f y, g z )
infixr 3 ***


{-| Map a function over the first argument of a tuple
-}
first : (a -> b) -> ( a, d ) -> ( b, d )
first f ( x, y ) =
    ( f x, y )


{-| See type signature
-}
second : (c -> d) -> ( a, c ) -> ( a, d )
second f ( x, y ) =
    ( x, f y )
