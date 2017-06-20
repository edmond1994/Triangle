import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


import Color exposing (..)
import Element exposing (..)
import Collage exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


roundRect : Html.Html msg
roundRect =
    svg
      [ Svg.Attributes.width "120", height "120", viewBox "0 0 120 120" ]
      [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ]



main =
  div []
  [
    div [] [ Html.text "aa" ]
  ]


{-
main =
  div []
  [
    div [] [ Html.text "aa" ]
  ]
-}
{-
main : Element
main =
  collage 300 300
    [makeSquare blue 50]

makeSquare color size =
  filled color (square size)
-}
