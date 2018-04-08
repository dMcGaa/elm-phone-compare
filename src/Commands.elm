module Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PhoneId, Phone)
import RemoteData


fetchPhones : Cmd Msg
fetchPhones =
  Http.get fetchPhonesUrl phonesDecoder
  |> RemoteData.sendRequest
  |> Cmd.map Msgs.OnFetchPhones


fetchPhonesUrl : String
fetchPhonesUrl =
  "http://localhost:4000/phones"


phonesDecoder : Decode.Decoder (List Phone)
phonesDecoder =
  Decode.list phoneDecoder


phoneDecoder : Decode.Decoder Phone
phoneDecoder =
  decode Phone
  |> required "id" Decode.string
  |> required "name" Decode.string
  |> required "level" Decode.int

savePhoneUrl : PhoneId -> String
savePhoneUrl phoneId =
  "http://localhost:4000/phones/" ++ phoneId

savePhoneRequest : Phone -> Http.Request Phone
savePhoneRequest phone =
  Http.request
    { body = phoneEncoder phone |> Http.jsonBody
    , expect = Http.expectJson phoneDecoder
    , headers = []
    , method = "PATCH"
    , timeout = Nothing
    , url = savePhoneUrl phone.id
    , withCredentials = False
    }

savePhoneCmd : Phone -> Cmd Msg
savePhoneCmd phone =
  savePhoneRequest phone
    |> Http.send Msgs.OnPhoneSave

phoneEncoder : Phone -> Encode.Value
phoneEncoder phone =
  let
    attributes =
      [( "id", Encode.string phone.id )
      ,( "name", Encode.string phone.name )
      ,( "level", Encode.int phone.level )
      ]
  in
    Encode.object attributes
