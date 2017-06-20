module TriangleDraw exposing (customVisual)

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import OpenSolid.Svg as Svg
import OpenSolid.Geometry.Types exposing (..)
import OpenSolid.Point2d as Point2d


import Html exposing (..)

point_color_correct = "black"


renderSolid_classic ( minX, minY ) ( maxX, maxY ) =
    Svg.render2d
        (BoundingBox2d
            { minX = minX
            , maxX = maxX
            , minY = minY
            , maxY = maxY
            }
        )

renderSolid ( minX, minY ) ( maxX, maxY ) =
    Svg.render2d
        (BoundingBox2d
            { minX = minX
            , maxX = maxX
            , minY = minY
            , maxY = maxY
            }
        )
---NEEDED
drawPointOfUser  =
    let
      point_color = point_color_correct
    in
    Svg.point2d
        { radius = 5
        , attributes =
            [ Attributes.stroke "black"
            , Attributes.fill point_color
            ]
        }


drawText : Point2d -> String -> String -> String -> Svg Never
drawText point tag anchor baseline =
    Svg.g []
        [
          Svg.text2d
            [ Attributes.textAnchor anchor
            , Attributes.alignmentBaseline baseline
            , Attributes.fill "black"
            ]
            point
            (tag)
        ]


customVisual =
    let
        base_width = 0
        base_height = 0
        area_width = 500
        area_height = 500

    in
        renderSolid ( base_width, base_height ) ( base_width + area_width, base_height + area_height )
          <| drawTriangleAndPoint (100, 100, 100, 200, 200, 100, 110, 190)  --This one to be used


drawTriangleAndPoint (x1_pixel, y1_pixel, x2_pixel, y2_pixel, x3_pixel, y3_pixel, x0_pixel, y0_pixel) =

    let
        x_vertice_1 = x1_pixel
        y_vertice_1 = y1_pixel
        x_vertice_2 = x2_pixel
        y_vertice_2 = y2_pixel
        x_vertice_3 = x3_pixel
        y_vertice_3 = y3_pixel
        x_point = x0_pixel
        y_point = y0_pixel
        p1 = Point2d ( x_vertice_1, y_vertice_1 )
        p2 = Point2d ( x_vertice_2, y_vertice_2 )
        p3 = Point2d ( x_vertice_3, y_vertice_3 )
        userPoint = Point2d ( x_point, y_point )
    in
      Svg.g []
      [
        Svg.triangle2d
          [ Attributes.stroke "blue"
          , Attributes.strokeWidth "5"
          , Attributes.strokeLinejoin "round"
          , Attributes.fill "white"
          ]
          (Triangle2d
              ( p1
              , p2
              , p3
              )
          )


        , drawPointOfUser (userPoint)
        , drawText p1 "(0,0)" "start" "baseline"
        , drawText p2 "(0,0)" "start" "baseline"
        , drawText p3 "(0,0)" "start" "baseline"
        , drawText userPoint "(0,0)" "start" "baseline"
      ]



--END NEEDED






main =
    div []
        [
            Html.text "An example:"
          , div []  [ customVisual ]
        ]
