
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import OpenSolid.Svg as Svg
import OpenSolid.Geometry.Types exposing (..)
import OpenSolid.Point2d as Point2d


import TriangleDraw

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }





-- FUNCTIONS

simpleToFloat numstring =
  Result.withDefault 0 (String.toFloat numstring)

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
        , Html.text "X coordinate"
        , Html.text "Y coordinate"
      ],
      div []
      [
        Html.text "Vertice 1: "
        , input [ type_ "text", placeholder "Input X", onInput X1 ] []
        , input [ type_ "text", placeholder "Input Y", onInput Y1 ] []
      ],
      div []
      [
        Html.text "Vertice 2: "
        , input [ type_ "text", placeholder "Input X", onInput X2 ] []
        , input [ type_ "text", placeholder "Input Y", onInput Y2 ] []
      ],
      div []
      [
        Html.text "Vertice 3: "
        , input [ type_ "text", placeholder "Input X", onInput X3 ] []
        , input [ type_ "text", placeholder "Input Y", onInput Y3 ] []
      ],
      div []
      [
        Html.text "Point:  "
        , input [ type_ "text", placeholder "Input X", onInput X0 ] []
        , input [ type_ "text", placeholder "Input Y", onInput Y0 ] []
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


      div []  --DOES NOT WORK
      [
        Html.text "Triangle visual: "
        ,TriangleDraw.customVisual
      ]
    ]





{-

You may see it in the wild in  Html Never  which means this HTML will never produce any messages.
You would need to write an event handler like  onClick ??? : Attribute Never  but how can we fill in the question marks?!
So there cannot be any event handlers on that HTML.

-}

{-
The 6th entry has this type:

    Html Msg

But the 7th is:

    Html Never

-}




