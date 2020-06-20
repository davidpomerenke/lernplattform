module Model exposing (Model)

import Graphql.Http
import RemoteData exposing (RemoteData)
import Set exposing (Set)


type alias Model =
    { showDevWarning : Bool
    , showForm : Bool
    , bundesland : Maybe String
    , schulart : Maybe String
    , klassenstufen : Set Int
    , fächer : List String
    , availableBundesland : RemoteData (Graphql.Http.Error (List String)) (List String)
    , availableSchulart : RemoteData (Graphql.Http.Error (List String)) (List String)
    , availableKlassenstufen : RemoteData (Graphql.Http.Error (List Int)) (List Int)
    }
