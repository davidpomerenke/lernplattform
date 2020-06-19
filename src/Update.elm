module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (HttpStatus(..), Model)
import Set


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HideDevWarning ->
            ( { model | showDevWarning = False }, Cmd.none )

        ShowForm ->
            ( { model | showForm = True }, Cmd.none )

        SetBundesland a ->
            ( { model
                | bundesland = Just a
                , schulart = Nothing
                , klassenstufen = Set.empty
                , availableSchulart = HttpLoading
              }
            , Cmd.none
            )

        SetSchulart a ->
            ( { model | schulart = Just a, klassenstufen = Set.empty }, Cmd.none )

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
