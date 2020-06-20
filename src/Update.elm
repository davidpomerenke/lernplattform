module Update exposing (update)

import Helpers.HttpRequests exposing (makeRequest)
import Json.Decode exposing (field, int, list, string)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RemoteData exposing (RemoteData(..))
import Set


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HideDevWarning ->
            ( { model | showDevWarning = False }, Cmd.none )

        ShowForm ->
            ( { model | showForm = True }, Cmd.none )

        SetBundesland bundesland ->
            ( { model
                | bundesland = Just bundesland
                , schulart = Nothing
                , klassenstufen = Set.empty
                , availableSchulart = Loading
              }
            , makeRequest
                ("select distinct schulart from lehrplan where bundesland = '" ++ bundesland ++ "';")
                (list (field "schulart" string))
                GotSchulartResponse
            )

        SetSchulart schulart ->
            case model.bundesland of
                Nothing ->
                    ( model, Cmd.none )

                Just bundesland ->
                    ( { model
                        | schulart = Just schulart
                        , klassenstufen = Set.empty
                        , availableKlassenstufe = Loading
                      }
                    , makeRequest
                        ("select distinct klassenstufe from lehrplan where bundesland = '"
                            ++ bundesland
                            ++ "' and schulart = '"
                            ++ schulart
                            ++ "';"
                        )
                        (list (field "klassenstufe" int))
                        GotKlassenstufeResponse
                    )

        ToggleKlassenstufe a ->
            let
                newModel =
                    { model
                        | klassenstufen =
                            if Set.member a model.klassenstufen then
                                Set.remove a model.klassenstufen

                            else
                                Set.insert a model.klassenstufen
                    }
            in
            ( newModel
            , Cmd.none
              -- httpRequestFach newModel
            )

        GotSchulartResponse schulart ->
            ( { model | availableSchulart = schulart }, Cmd.none )

        GotKlassenstufeResponse klassenstufe ->
            ( { model | availableKlassenstufe = klassenstufe }, Cmd.none )
