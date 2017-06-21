module Main exposing (..)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col


main =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , myViewFn
        ]


myViewFn =
    Grid.row [ Row.centerXs ]
        [ Grid.col [ Col.xs2 ]
            [ text "Col 1" ]
        , Grid.col [ Col.xs4 ]
            [ text "Col 2" ]
        ]
