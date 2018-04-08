module Phones.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Phone)
import Routing exposing (phonesPath)


view : Phone -> Html Msg
view model =
  div []
  [ nav model
  , form model
  ]


nav : Phone -> Html Msg
nav model =
  div [ class "clearfix mb2 white bg-black p1" ]
    [ listBtn ]


form : Phone -> Html Msg
form phone =
  div [ class "m3" ]
  [ h1 [] [ text phone.name ]
  , formLevel phone
  ]


formLevel : Phone -> Html Msg
formLevel phone =
  div
  [ class "clearfix py1"
  ]
  [ div [ class "col col-5" ] [ text "Level" ]
  , div [ class "col col-7" ]
  [ span [ class "h2 bold" ] [ text (toString phone.level) ]
  , btnLevelDecrease phone
  , btnLevelIncrease phone
  ]
  ]


btnLevelDecrease : Phone -> Html Msg
btnLevelDecrease phone =
  let
    message = 
      Msgs.ChangeLevel phone -1
  in
    a [ class "btn ml1 h1", onClick message ]
      [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Phone -> Html Msg
btnLevelIncrease phone =
  let
    message =
      Msgs.ChangeLevel phone 1
  in
    a [ class "btn ml1 h1", onClick message ]
      [ i [ class "fa fa-plus-circle" ] [] ]

listBtn : Html Msg
listBtn =
  a
    [ class "btn regular"
    , href phonesPath
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
