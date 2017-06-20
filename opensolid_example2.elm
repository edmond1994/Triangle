--http://package.elm-lang.org/packages/opensolid/svg/1.1.0/OpenSolid-Svg

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import OpenSolid.Svg as Svg
import OpenSolid.Geometry.Types exposing (..)
import OpenSolid.Point2d as Point2d


import Html exposing (..)


--render2d  - NO INFO



myTriangle : Svg Never
myTriangle =
    Svg.triangle2d
        [ Attributes.stroke "blue"
        , Attributes.strokeWidth "5"
        , Attributes.strokeLinejoin "round"
        , Attributes.fill "white"
        ]
        (Triangle2d
            ( Point2d ( 100, 100 )
            , Point2d ( 200, 100 )
            , Point2d ( 100, 200 )
            )
        )


-- renderSolid ( 90, 90 ) ( 210, 210 ) myTriangle
-- renderSolid : ( Float, Float ) -> ( Float, Float ) -> Svg Never -> Html Never
renderSolid ( minX, minY ) ( maxX, maxY ) =
    Svg.render2d
        (BoundingBox2d
            { minX = minX
            , maxX = maxX
            , minY = minY
            , maxY = maxY
            }
        )

triangle_view =
    renderSolid ( 90, 90 ) ( 210, 210 ) myTriangle


triangle_view_2 =
    renderSolid ( 90, 90 ) ( 510, 510 ) myTriangle







drawPoint  =
    Svg.point2d
        { radius = 5
        , attributes =
            [ Attributes.stroke "black"
            , Attributes.fill "red"
            ]
        }


point_color_correct = "black"





pointSvg =
    let
        points =
            [ Point2d ( 100, 100 )
            , Point2d ( 200, 200 )
            , Point2d ( 110, 130 )
            , Point2d ( 140, 180 )
            , Point2d ( 170, 110 )
            , Point2d ( 180, 150 )
            , Point2d ( 110, 190 )
            ]
    in
        Svg.g [] (List.map drawPoint points)


points_draw =
    renderSolid ( 90, 90 ) ( 510, 510 ) pointSvg

customVisual_old =
    drawPointOfUser (Point2d ( 110, 190 )) |> renderSolid ( 90, 90 ) ( 510, 510 )



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
        renderSolid ( base_width, base_height ) ( base_width + area_width, base_height + area_height ) drawTriangleAndPoint   --This one to be used


drawTriangleAndPoint =

    let
        x_vertice_1 = 100
        y_vertice_1 = 100
        x_vertice_2 = 200
        y_vertice_2 = 100
        x_vertice_3 = 100
        y_vertice_3 = 200
        x_point = 110
        y_point = 190
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
          --, div []  [ triangle_view ]
          , div []  [ customVisual ]
          --, div []  [ triangle_view_2 ]
        ]
