module Model exposing (Model, Page(..), FormData, User)

import Dict exposing (Dict)
import RemoteData exposing (WebData)
import Set exposing (Set)


type alias Model =
    { user : Maybe User
    , page : Page
    , showDevWarning : Bool
    }


type alias User =
    { region : String
    , school : String
    , subjectsByClass : Dict Int (Set String)
    }


type Page
    = Form FormData
    | Content


type alias FormData =
    { region : Maybe String
    , school : Maybe String
    , subjectsByClass : Dict Int (Set String)
    , availableRegions : WebData (List String)
    , availableSchools : WebData (List String)
    , availableClasses : WebData (List Int)
    , availableSubjectsByClass : Dict Int (WebData (List String))
    }
