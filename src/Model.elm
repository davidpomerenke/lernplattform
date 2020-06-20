module Model exposing (Model)

import RemoteData exposing (WebData)
import Set exposing (Set)


type alias Model =
    { showDevWarning : Bool
    , showForm : Bool
    , bundesland : Maybe String
    , schulart : Maybe String
    , klassenstufen : Set Int
    , fächer : List String
    , availableBundesland : WebData (List String)
    , availableSchulart : WebData (List String)
    , availableKlassenstufe : WebData (List Int)
    }
