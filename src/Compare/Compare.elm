module Compare.Compare exposing (..)

import Html exposing (..)

--import Msgs exposing (Msg)
import Models exposing (Compare)
--import Routing exposing (comparePath)

view : Compare -> Html msg
view model =
  div []
  [div [] [ text model ]]

