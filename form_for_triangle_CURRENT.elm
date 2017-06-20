
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Svg exposing (..)
import Svg.Attributes exposing (..)

import String exposing (..)


import TriangleDraw

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
--note that if simply copy Main from Draw, all works, so the problem is with types





-- FUNCTIONS

filter_Input numstring =
  trim(numstring)

simpleToFloat numstring =
  Result.withDefault 0 (String.toFloat <| filter_Input(numstring))

computeForSide (x_side1, y_side1) (x_side2, y_side2) (x,y) =
  ((x_side1 - x)*(y_side2 - y_side1)) - ((x_side2 - x_side1)*(y_side1 - y))



-- Function for computing triangle
computeForTriangle (xa,ya) (xb,yb) (xc,yc) (x,y) =
  (
       (computeForSide (xa,ya) (xb,yb) (x,y) > 0)
    && (computeForSide (xb,yb) (xc,yc) (x,y) > 0)
    && (computeForSide (xc,yc) (xa,ya) (x,y) > 0)
  )||
  (
       (computeForSide (xa,ya) (xb,yb) (x,y) < 0)
    && (computeForSide (xb,yb) (xc,yc) (x,y) < 0)
    && (computeForSide (xc,yc) (xa,ya) (x,y) < 0)
  )
  --Note: since =0 automatically means false (point is on the edge), there is no need to check for it



-------------VISUALIZATION


--using Model

visualizeTriangle model_triangle = --drawing a triangle from our model
    0
















-- MODEL


type alias Model =
  { x1 : Float  --triangle vertice 1
  , y1 : Float
  , x2 : Float  --triangle vertice 2
  , y2 : Float
  , x3 : Float  --triangle vertice 3
  , y3 : Float
  , x0 : Float  --point
  , y0 : Float
  }




model : Model
model =
  Model 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0





-- UPDATE


type Msg
    = X1 String
    | Y1 String
    | X2 String
    | Y2 String
    | X3 String
    | Y3 String
    | X0 String
    | Y0 String
    -- | Never  --does not work to solve A1


update : Msg -> Model -> Model
update msg model =
  case msg of
    X0 number ->
      { model | x0 = simpleToFloat(number) }

    X1 number ->
      { model | x1 = simpleToFloat(number) }

    X2 number ->
      { model | x2 = simpleToFloat(number) }

    X3 number ->
      { model | x3 = simpleToFloat(number) }

    Y0 number ->
      { model | y0 = simpleToFloat(number) }

    Y1 number ->
      { model | y1 = simpleToFloat(number) }

    Y2 number ->
      { model | y2 = simpleToFloat(number) }

    Y3 number ->
      { model | y3 = simpleToFloat(number) }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [
      div []
      [
        Html.text "Input coordinates: "
        , Html.text "   X coordinate  "
        , Html.text "   Y coordinate  "
      ],
      div []
      [
        Html.text "Vertice 1: "
        , input [ Html.Attributes.type_ "text", placeholder "X = 0", onInput X1 ] []
        , input [ Html.Attributes.type_ "text", placeholder "Y = 0", onInput Y1 ] []
      ],
      div []
      [
        Html.text "Vertice 2: "
        , input [ Html.Attributes.type_ "text", placeholder "X = 0", onInput X2 ] []
        , input [ Html.Attributes.type_ "text", placeholder "Y = 0", onInput Y2 ] []
      ],
      div []
      [
        Html.text "Vertice 3: "
        , input [ Html.Attributes.type_ "text", placeholder "X = 0", onInput X3 ] []
        , input [ Html.Attributes.type_ "text", placeholder "Y = 0", onInput Y3 ] []
      ],
      div []
      [
        Html.text "Point:  "
        , input [ Html.Attributes.type_ "text", placeholder "X = 0", onInput X0 ] []
        , input [ Html.Attributes.type_ "text", placeholder "Y = 0", onInput Y0 ] []
      ],
      div []
      [
        Html.text "Result:  ",
        Html.text
          (
            if computeForTriangle (
               (model.x1),  (model.y1)
              )
              (
               (model.x2),  (model.y2)
              )
              (
               (model.x3),  (model.y3)
              )
              (
               (model.x0),  (model.y0)
              )
            then
              "Point is in triangle "
            else
              "Point is not in triangle "

          )
      ],
      div []
      [
        ul []
          [ li [] [Html.text <| ("x1:  " ++ toString(model.x1))]
          , li [] [Html.text <| ("y1:  " ++ toString(model.y1))]
          , li [] [Html.text <| ("x2:  " ++ toString(model.x2))]
          , li [] [Html.text <| ("y2:  " ++ toString(model.y2))]
          , li [] [Html.text <| ("x3:  " ++ toString(model.x3))]
          , li [] [Html.text <| ("y3:  " ++ toString(model.y3))]
          , li [] [Html.text <| ("x0:  " ++ toString(model.x0))]
          , li [] [Html.text <| ("y0:  " ++ toString(model.y0))]
          ]


      ]

      {-div []  --DOES NOT WORK
      [
        Html.text "Triangle visual: ",
        TriangleDraw.customVisual
        {-
        svg
        [ Svg.Attributes.width "400", Svg.Attributes.height "400", viewBox "0 0 400 400" ]
        [ rect [ x "25", y "25", Svg.Attributes.width "350", Svg.Attributes.height "350", rx "15", ry "15" ] [] ]

        -}
      ]-}

     ]






{-

You may see it in the wild in  Html Never  which means this HTML will never produce any messages.
You would need to write an event handler like  onClick ??? : Attribute Never  but how can we fill in the question marks?!
So there cannot be any event handlers on that HTML.

-}

{- A1
The 6th entry has this type:

    Html Msg

But the 7th is:

    Html Never

-} --The error remains even if code is directly in this file




