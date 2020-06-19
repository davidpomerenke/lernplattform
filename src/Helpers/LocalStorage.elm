port module Helpers.LocalStorage exposing (initWithStorage, updateWithStorage)

import Json.Decode as D
import Json.Decode.Extra as D
import Json.Decode.Pipeline exposing (hardcoded, required)
import Json.Encode as E
import Messages exposing (Msg)
import Model exposing (Model, HttpStatus(..))
import Set
import Update exposing (update)
import Helpers.Data exposing (availableBundesland)


initWithStorage : Model -> List (Cmd Msg) -> D.Value -> ( Model, Cmd Msg )
initWithStorage initialModel commands flags =
    ( -- try to read from local storage
      case D.decodeValue decoder flags of
        Ok m ->
            m

        Err _ ->
            initialModel
    , Cmd.batch commands
    )



-- PORTS
-- save model on update


port setStorage : E.Value -> Cmd msg


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg oldModel =
    let
        ( newModel, cmds ) =
            update msg oldModel
    in
    ( newModel
    , Cmd.batch [ setStorage (encode newModel), cmds ]
    )



-- JSON ENCODE/DECODE
-- local storage <-> model


encode : Model -> E.Value
encode model =
    E.object
        [ ( "showDevWarning", E.bool model.showDevWarning )
        , ( "showForm", E.bool model.showForm )
        , ( "bundesland", E.string (Maybe.withDefault "" model.bundesland) )
        , ( "schulart", E.string (Maybe.withDefault "" model.schulart) )
        , ( "klassenstufen", E.list E.int (Set.toList model.klassenstufen) )
        ]


decoder : D.Decoder Model
decoder =
    D.succeed Model
        |> required "showDevWarning" D.bool
        |> required "showForm" D.bool
        |> required "bundesland" (D.nullable D.string)
        |> required "schulart" (D.nullable D.string)
        |> required "klassenstufen" (D.set D.int)
        |> hardcoded []
        |> hardcoded availableBundesland
        |> hardcoded HttpNotRequested
        |> hardcoded HttpNotRequested
