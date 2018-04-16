module Compare.Compare exposing (..)

--import Msgs exposing (Msg)

import Html exposing (..)
import Models exposing (Phone)
import RemoteData exposing (WebData)


--import Routing exposing (comparePath)


view : WebData (List Phone) -> Html msg
view response =
    div [] [ maybeList response ]


compareView : List Phone -> Html msg
compareView phones =
    div []
        [ div [] (List.map nameView phones)
        , div [] (List.map specView phones)
        ]


nameView : Phone -> Html msg
nameView phone =
    div []
        [ span [] [ text phone.name ] ]


specView : Phone -> Html msg
specView phone =
    div []
        [ span [] [ text (toString phone.level) ] ]


maybeList : WebData (List Phone) -> Html msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success phones ->
            compareView phones

        RemoteData.Failure error ->
            text (toString error)
