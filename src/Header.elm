module Header exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, value)


appHeader : Html msg
appHeader =
    div []
        [ headerNav ]


headerNav : Html msg
headerNav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ navLinks ]


navLinks : Html msg
navLinks =
    a
        [ class "btn regular"
        , href "/"
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Home" ]
