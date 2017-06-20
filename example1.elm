--module Example1 exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)

over9000 powerLevel =
  if powerLevel > 9000 then "It's over 9000!!!" else "meh"

names = [ "Alice", "Bob", "Chuck" ]


--function
add : Int -> Int -> Int
add x y =
  x + y

main =
  div []
  [
    div [] [ text (over9000 42) ]
  , div [] [ text (over9000 111142) ]
  , div [] [ text (toString names) ]
  ]




