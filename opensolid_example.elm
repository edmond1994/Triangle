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








drawPoint =
    Svg.point2d
        { radius = 3
        , attributes =
            [ Attributes.stroke "blue"
            , Attributes.fill "orange"
            ]
        }



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





main =
    div []
        [
            Html.text "An example:"
          , div []  [ triangle_view ]
          , div []  [ triangle_view_2 ]
          , div []  [ points_draw ]
        ]
