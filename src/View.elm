module View exposing (..)

import Compare.Compare
import Html exposing (Html, div, text)
import Models exposing (Model, Phone, PhoneId)
import Msgs exposing (Msg)
import Phones.Edit
import Phones.List
import Phones.SinglePhone
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PhonesRoute ->
            Phones.List.view model.phones

        Models.PhoneRoute id ->
            phoneEditPage model id

        Models.CompareRoute ->
            Compare.Compare.view model.phones

        Models.ActivePhoneRoute ->
            Phones.SinglePhone.view model.activePhone

        Models.NotFoundRoute ->
            notFoundView


phoneEditPage : Model -> PhoneId -> Html Msg
phoneEditPage model phoneId =
    case model.phones of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success phones ->
            let
                maybePhone =
                    phones
                        |> List.filter (\phone -> phone.id == phoneId)
                        |> List.head
            in
            case maybePhone of
                Just phone ->
                    Phones.Edit.view phone

                Nothing ->
                    notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
