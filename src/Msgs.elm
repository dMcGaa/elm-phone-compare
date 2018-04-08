module Msgs exposing (..)

import Models exposing (Phone)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http

type Msg
  = OnFetchPhones (WebData (List Phone))
  | OnLocationChange Location
  | OnPhoneSave (Result Http.Error Phone)
  | ChangeLevel Phone Int
