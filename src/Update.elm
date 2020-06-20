module Update exposing (update)

import Helpers.GraphqlRequests exposing (makeSchulartRequest)
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
            , makeSchulartRequest bundesland
            )

        SetSchulart schulart ->
            ( { model | schulart = Just schulart, klassenstufen = Set.empty }, Cmd.none )

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

        GotSchulartResponse response ->
            ( { model | availableSchulart = response }, Cmd.none )
