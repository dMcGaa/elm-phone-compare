module Phones.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Phone)
import RemoteData exposing (WebData)
import Routing exposing (phonePath)

view : WebData (List Phone) -> Html Msg
view response = 
  div []
    [ nav
    , maybeList response
    ]


nav : Html Msg
nav =
  div [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Phones" ] ]

list : List Phone -> Html Msg
list phones =
  div [ class "p2" ]
    [ table []
      [ thead []
        [ tr []
          [ th [][ text "Id"]
          , th [][ text "Name" ]
          , th [][ text "Level" ]
          , th [][ text "Actions" ]
          ]
        ]
      , tbody [] (List.map phoneRow phones)
      ]
    ]

phoneRow : Phone -> Html Msg
phoneRow phone =
  tr []
    [ td [] [text phone.id ]
    , td [] [text phone.name ]
    , td [] [text (toString phone.level)]
    , td []
      [ editBtn phone ]
    ]

maybeList : WebData (List Phone) -> Html Msg
maybeList response =
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success phones ->
      list phones

    RemoteData.Failure error ->
      text (toString error)

editBtn : Phone -> Html.Html Msg
editBtn phone =
  let
    path =
      phonePath phone.id
  in
    a
      [ class "btn regular"
      , href path
      ]
      [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
