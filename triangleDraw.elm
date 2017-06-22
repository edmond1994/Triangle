module TriangleDraw exposing (customVisual, returnVal1)

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import OpenSolid.Svg as Svg
import OpenSolid.Geometry.Types exposing (..)
import OpenSolid.Point2d as Point2d


import Html exposing (..)



renderSolid ( minX, minY ) ( maxX, maxY ) =
    Svg.render2d
        (BoundingBox2d
            { minX = minX
            , maxX = maxX
            , minY = minY
            , maxY = maxY
            }
        )

drawPointOfUser pointColor =
    let

      point_color = pointColor

    in

    Svg.point2d
        { radius = 5
        , attributes =
            [ Attributes.stroke "black"
            , Attributes.fill point_color
            ]
        }





drawText point tag anchor baseline =
          Svg.text2d
            [ Attributes.textAnchor anchor
            , Attributes.alignmentBaseline baseline
            , Attributes.fill "black"
            ]
            point
            (tag)

base_width = 0
base_height = 0
area_width = 520
area_height = 520

customVisual model val_For_Color =
    let

        xs = [model.x1, model.x2, model.x3, model.x0]
        ys = [model.y1, model.y2, model.y3, model.y0]

        xMin = returnVal1(List.minimum xs)
        yMin = returnVal1(List.minimum ys)
        xMax = returnVal1(List.maximum xs)
        yMax = returnVal1(List.maximum ys)

        xDist = xMax - xMin
        yDist = yMax - yMin

        --xyTuples = List.map2 (,) xs ys   --coords

        pixel1 = createPixel xDist yDist xMin yMin xMax yMax (model.x1, model.y1) True
        pixel2 = createPixel xDist yDist xMin yMin xMax yMax (model.x2, model.y2) True
        pixel3 = createPixel xDist yDist xMin yMin xMax yMax (model.x3, model.y3) True
        pixel0 = createPixel xDist yDist xMin yMin xMax yMax (model.x0, model.y0) True
    in
        renderSolid ( base_width, base_height ) ( base_width + area_width, base_height + area_height )

        <|drawTriangleAndPoint val_For_Color model pixel1 pixel2 pixel3 pixel0


createPixel xDist yDist xMin yMin xMax yMax tuplePixel reserved_bool =
    let
      x_coor = Tuple.first(tuplePixel)
      y_coor = Tuple.second(tuplePixel)

      border_1 = 40


      base_pixel_x = base_width  + border_1
      base_pixel_y = base_height + border_1


      base_max_x = area_width - border_1
      base_max_y = area_height - border_1

      propDist =
          if(xDist>0 && yDist>0) then
            yDist/xDist
          else
            1


      xDist1 =
      if xDist>0 then
        xDist
      else
        1   --CAREFUL, NOT FULLY TESTED


      yDist1 =
      if yDist>0 then
        yDist
      else
        1  --CAREFUL, NOT FULLY TESTED

      x_pixel =


      if(xDist>yDist) then   --if the "box" is wider than taller
          base_pixel_x +

          (((x_coor - xMin)/xDist1)   --point's relative position between xMin and xMax
          * (base_max_x - base_pixel_x))*1

      else
          base_pixel_x +
          (((x_coor - xMin)/xDist1)   --point's relative position between xMin and xMax
          * (base_max_x - base_pixel_x))*(1/propDist)






      y_pixel =

      if(xDist>yDist) then
          base_pixel_y +

          (((y_coor - yMin)/yDist1) --point's relative position between yMin and yMax
          * (base_max_y - base_pixel_y))*propDist

      else
          base_pixel_y +

          (((y_coor - yMin)/yDist1) --point's relative position between yMin and yMax
          * (base_max_y - base_pixel_y))*1





    in
      (x_pixel, y_pixel)



chooseColorOfPoint boolValue1 =

    if boolValue1
        then
           "green"
        else
            "red"


drawTriangleAndPoint val_For_Color model pixel1 pixel2 pixel3 pixel0 =

    let

        vertice1 = Point2d ( Tuple.first(pixel1), Tuple.second(pixel1) )
        vertice2 = Point2d ( Tuple.first(pixel2), Tuple.second(pixel2) )
        vertice3 = Point2d ( Tuple.first(pixel3), Tuple.second(pixel3) )
        userPoint = Point2d ( Tuple.first(pixel0), Tuple.second(pixel0) )
        pointColor = chooseColorOfPoint val_For_Color

    in
      Svg.g []
      [
        Svg.triangle2d
          [ Attributes.stroke "blue"
          , Attributes.strokeWidth "2"
          , Attributes.strokeLinejoin "round"
          , Attributes.fill "white"
          ]
          (Triangle2d
              ( vertice1
              , vertice2
              , vertice3
              )
          )

        , drawPointOfUser pointColor userPoint
        , drawText vertice1 (printCoord model.x1 model.y1) "baseline" "baseline"
        , drawText vertice2 (printCoord model.x2 model.y2) "baseline" "baseline"
        , drawText vertice3 (printCoord model.x3 model.y3) "baseline" "baseline"
        , drawText userPoint (printCoord model.x0 model.y0) "baseline" "baseline"
      ]



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

model1 : Model
model1 =
  Model 10.0 0.0 0.0 12.0 0.0 0.0 1.0 1.0

main =
    div []
        [
            Html.text "An example:",
            Html.text (

              toString(  returnVal1(List.minimum[4,2,1]))

            ),
            Html.text (



                 toString <|Tuple.first(List.unzip <| (List.map2 (,) [1.0, 2.0, 3.0] [1.0, 3.0, 2.0])) ++ Tuple.second(List.unzip <| (List.map2 (,) [1.0, 2.0, 3.0] [1.0, 3.0, 2.0]))

                --toString(List.map createPixel (List.map2 (,) [1.0, 2.0, 3.0] [1.0, 3.0, 2.0])) --maps correctly

            ),
            customVisual model1 False
        ]





returnVal1 value =
  Maybe.withDefault 0 (value)

printCoord xcoor ycoor =
  "("++toString(xcoor)++";"++toString(ycoor)++")"






