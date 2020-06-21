module Model exposing (Model)

import Dict exposing (Dict)
import RemoteData exposing (WebData)
import Set exposing (Set)


type alias Model =
    { showDevWarning : Bool
    , showForm : Bool
    , bundesland : Maybe String
    , schulart : Maybe String
    , fächerByKlassenstufe : Dict Int (Set String)
    , availableBundesland : WebData (List String)
    , availableSchulart : WebData (List String)
    , availableKlassenstufe : WebData (List Int)
    , availableFachByKlassenstufe : Dict Int (WebData (List String))
    }
