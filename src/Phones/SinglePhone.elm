module Phones.SinglePhone exposing (..)

import Html exposing (..)
import Models exposing (Phone)


view : Phone -> Html msg
view model =
    div [] [ page model ]


page : Phone -> Html msg
page model =
    div [] [ text model.id ]
