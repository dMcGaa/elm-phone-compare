module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Phone)
import Routing exposing (parseLocation)
import Commands exposing (savePhoneCmd)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Msgs.OnFetchPhones response ->
      ( { model | phones = response }, Cmd.none)
    Msgs.OnLocationChange location ->
      let
        newRoute =
          parseLocation location
      in
        ({ model | route = newRoute }, Cmd.none)
    Msgs.ChangeLevel phone howMuch ->
      let
        updatedPhone =
          { phone | level = phone.level + howMuch }
      in
        ( model, savePhoneCmd updatedPhone )
    Msgs.OnPhoneSave (Ok phone) ->
      ( updatePhone model phone, Cmd.none )
    Msgs.OnPhoneSave (Err error) ->
      ( model, Cmd.none )

updatePhone : Model -> Phone -> Model
updatePhone model updatedPhone =
  let
    pick currentPhone =
      if updatedPhone.id == currentPhone.id then
        updatedPhone
      else
        currentPhone

    updatePhoneList phone =
      List.map pick phone

    updatedPhones =
      RemoteData.map updatePhoneList model.phones

  in
    { model | phones = updatedPhones }
