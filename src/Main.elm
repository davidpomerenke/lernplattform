module Main exposing (main)

import Browser
import Helpers.Data exposing (availableBundesland)
import Helpers.LocalStorage exposing (initWithStorage, updateWithStorage)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RemoteData exposing (RemoteData(..))
import Update exposing (update)
import View exposing (view)
import Dict


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
    { showDevWarning = True
    , showForm = True
    , bundesland = Nothing
    , schulart = Nothing
    , fächerByKlassenstufe = Dict.empty
    , availableBundesland = Success availableBundesland
    , availableSchulart = NotAsked
    , availableKlassenstufe = NotAsked
    , availableFachByKlassenstufe = Dict.empty
    }


initialCommands : List (Cmd Msg)
initialCommands =
    []
