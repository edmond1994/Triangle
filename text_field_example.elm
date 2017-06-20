import Html exposing (Html, Attribute, beginnerProgram, text, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


main =
  beginnerProgram { model = "", view = view, update = update }



-- FUNCTION

mBy2 : Int -> Int
mBy2 x =
  2*x


func1 : Int -> Int
func1 x =
  x-1

-- UPDATE

type Msg = NewContent String

update (NewContent content) oldContent =
  content


-- VIEW

view content =
  div []
    [ input [ placeholder "0", onInput NewContent, myStyle ] []
    , div [ myStyle ]

      [
        text

          (toString
            (func1
              --(String.toInt(content))
              (Result.withDefault 0 (String.toInt content))
            )
          )
      ] --nesting

   --, div [ myStyle ] [ text (String.reverse content) ]
    ]

myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]
