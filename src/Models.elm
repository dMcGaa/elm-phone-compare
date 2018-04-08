module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
  { phones : WebData (List Phone)
  , route : Route
  }


initialModel : Route -> Model
initialModel route =
  { phones = RemoteData.Loading
  , route = route
  }


type alias PhoneId =
  String


type alias Phone =
  { id : PhoneId
  , name : String
  , level : Int
  }

type Route
  = PhonesRoute
  | PhoneRoute PhoneId
  | NotFoundRoute
