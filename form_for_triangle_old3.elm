--here to work on numeration
--CHANGE FROM old2: made internal values Float instead of String

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

{-
import Svg exposing (..)
import Collage exposing (..) --exists
import Element exposing (..) --exists
import Color exposing (..)   --exists
-}

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




--using Model

vizualizeTriangle model_triangle = --drawing a triangle from our model
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
            --if computeForTriangle (4.6, -1.02) (6.3, 4.38) (12.14, 2.58) (7.78, 2.38) then  --here to paste the result  --SEEMS TO BE WORKING
            --if True then
          )
      ],

      div []
      [
          --collage 100 100 []


      ]


    ]
















{- ADDITIONAL

-- Additional Materials

type alias Point =
  { x : Float  --triangle vertice 1
  , y : Float
  }
computeForTriangle : Point -> Point -> Point -> Point -> Bool
computeForSide : Point -> Point -> Point -> Float



 {-
    (computeForSide (xa,ya) (xb,yb) (x,y) )
    + (computeForSide (xb,yb) (xc,yc) (x,y) )
    + (computeForSide (xc,yc) (xa,ya) (x,y) )
  -}


vizualizeTriangle : Model -> Int  --IS WORKING






-------ON GEOMETRY
---Change from old2: added import from OpenSolid
import OpenSolid.Geometry.Types exposing (..)
---triangle  --DOES NOT CAUSE ERROR
triangle =
      Polygon2d
          [ Point2d ( model.x1, model.y1 )
          , Point2d ( model.x2, model.y2 )
          , Point2d ( model.x3, model.y3 )
          ]


-}
---polyline [ fill "none", stroke "black", points "20,100 40,60 70,80 100,20" ] []




{-


import Svg exposing (..)
import Svg.Attributes exposing (..)


-}
