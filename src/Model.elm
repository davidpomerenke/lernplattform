module Model exposing (HttpStatus(..), Model)

import Set exposing (Set)

type alias Model =
    { showDevWarning : Bool
    , showForm : Bool
    , bundesland : Maybe String
    , schulart : Maybe String
    , klassenstufen : Set Int
    , fächer : List String
    , availableBundesland : HttpStatus (List String)
    , availableSchulart : HttpStatus (List String)
    , availableKlassenstufen : HttpStatus (List Int)
    }



-- for status of a http request


type HttpStatus result
    = HttpNotRequested
    | HttpFailure
    | HttpLoading
    | HttpSuccess result
