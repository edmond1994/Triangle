import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

roundRect : Html.Html msg
roundRect =
    svg
      [ width "120", height "120", viewBox "0 0 120 120" ]
      [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ]



roundRect_copy =
    svg
      [ width "400", height "400", viewBox "0 0 400 400" ]
      [ rect [ x "25", y "25", width "350", height "350", rx "15", ry "15" ] [] ]


main =
  div []
  [
    div [] [ Html.text "1" ]
  , div [] [ Svg.text "1" ]
  , div [] [ Html.text "1" ]
  , div [] [ roundRect_copy ]
  ]
