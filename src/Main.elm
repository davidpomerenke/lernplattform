module Main exposing (main)

import Browser
import Dict
import Helpers.Data
import Helpers.LocalStorage exposing (initWithStorage, updateWithStorage)
import Json.Decode
import Messages exposing (Msg(..))
import Model exposing (FormData, Model, Page(..))
import RemoteData exposing (RemoteData(..))
import View exposing (view)


main : Program Json.Decode.Value Model Msg
main =
    Browser.element
        { init = initWithStorage initialModel initialCommands
        , update = updateWithStorage
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- INIT


initialModel : Model
initialModel =
    { user = Nothing
    , page = Form initialFormData
    , showDevWarning = True
    }


initialFormData : FormData
initialFormData =
    { region = Nothing
    , school = Nothing
    , subjectsByClass = Dict.empty
    , availableRegions = Success Helpers.Data.availableRegions
    , availableSchools = NotAsked
    , availableClasses = NotAsked
    , availableSubjectsByClass = Dict.empty
    }


initialCommands : List (Cmd Msg)
initialCommands =
    []
