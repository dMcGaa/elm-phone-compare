module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { phones : WebData (List Phone)
    , compare : Compare
    , route : Route
    , activePhone : Phone
    }


initialModel : Route -> Model
initialModel route =
    { phones = RemoteData.Loading
    , compare = "test"
    , route = route
    , activePhone =
        { id = "sample phone"
        , name = ""
        , level = 0
        }
    }


type alias PhoneId =
    String


type alias Phone =
    { id : PhoneId
    , name : String
    , level : Int
    }


type alias Compare =
    String


type Route
    = PhonesRoute
    | PhoneRoute PhoneId
    | CompareRoute
    | ActivePhoneRoute
    | NotFoundRoute
