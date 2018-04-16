module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PhoneId, Route(..))
import UrlParser exposing (..)

phonesPath : String
phonesPath = 
  "#phones"

phonePath : PhoneId -> String
phonePath id =
  "#phones/" ++ id

comparePath : String
comparePath =
  "#compare"

activePhonePath : String
activePhonePath =
  "#activePhone"

matchers : Parser (Route -> a) a
matchers = 
  oneOf
    [ map PhonesRoute top
    , map PhoneRoute (s "phones" </> string)
    , map PhonesRoute (s "phones")
    , map CompareRoute (s "compare")
    , map ActivePhoneRoute (s "active-phone")
    ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    Nothing ->
      NotFoundRoute

