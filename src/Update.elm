module Update exposing (update)

import Dict
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
                , fächerByKlassenstufe = Dict.empty
                , availableSchulart = Loading
                , availableKlassenstufe = NotAsked
                , availableFachByKlassenstufe = Dict.empty
              }
            , makeRequest
                ("select distinct schulart from lehrplan where bundesland = '" ++ bundesland ++ "';")
                (list (field "schulart" string))
                (\schulart -> GotSchulartResponse { bundesland = bundesland, schulart = schulart })
            )

        SetSchulart schulart ->
            case model.bundesland of
                Nothing ->
                    ( model, Cmd.none )

                Just bundesland ->
                    ( { model
                        | schulart = Just schulart
                        , fächerByKlassenstufe = Dict.empty
                        , availableKlassenstufe = Loading
                        , availableFachByKlassenstufe = Dict.empty
                      }
                    , makeRequest
                        ("select distinct klassenstufe from lehrplan where bundesland = '"
                            ++ bundesland
                            ++ "' and schulart = '"
                            ++ schulart
                            ++ "';"
                        )
                        (list (field "klassenstufe" int))
                        (\klassenstufe ->
                            GotKlassenstufeResponse
                                { bundesland = bundesland
                                , schulart = schulart
                                , klassenstufe = klassenstufe
                                }
                        )
                    )

        ToggleKlassenstufe klassenstufe ->
            case model.bundesland of
                Nothing ->
                    ( model, Cmd.none )

                Just bundesland ->
                    case model.schulart of
                        Nothing ->
                            ( model, Cmd.none )

                        Just schulart ->
                            ( { model
                                | fächerByKlassenstufe =
                                    if Dict.member klassenstufe model.fächerByKlassenstufe then
                                        Dict.remove klassenstufe model.fächerByKlassenstufe

                                    else
                                        Dict.insert klassenstufe Set.empty model.fächerByKlassenstufe
                                , availableFachByKlassenstufe =
                                    if Dict.member klassenstufe model.availableFachByKlassenstufe then
                                        Dict.remove klassenstufe model.availableFachByKlassenstufe

                                    else
                                        Dict.insert klassenstufe Loading model.availableFachByKlassenstufe
                              }
                            , if Dict.member klassenstufe model.fächerByKlassenstufe then
                                Cmd.none

                              else
                                makeRequest
                                    ("select distinct fach from lehrplan where bundesland = '"
                                        ++ bundesland
                                        ++ "' and schulart = '"
                                        ++ schulart
                                        ++ "' and klassenstufe = '"
                                        ++ String.fromInt klassenstufe
                                        ++ "';"
                                    )
                                    (list (field "fach" string))
                                    (\fächer ->
                                        GotFachResponse
                                            { bundesland = bundesland
                                            , schulart = schulart
                                            , klassenstufe = klassenstufe
                                            , fächer = fächer
                                            }
                                    )
                            )

        ToggleFach ( klassenstufe, fach ) ->
            case model.bundesland of
                Nothing ->
                    ( model, Cmd.none )

                Just bundesland ->
                    case model.schulart of
                        Nothing ->
                            ( model, Cmd.none )

                        Just schulart ->
                            ( { model
                                | fächerByKlassenstufe =
                                    Dict.update klassenstufe
                                        (\v ->
                                            case v of
                                                Nothing ->
                                                    Just Set.empty

                                                Just fächer ->
                                                    if Set.member fach fächer then
                                                        Just (Set.remove fach fächer)

                                                    else
                                                        Just (Set.insert fach fächer)
                                        )
                                        model.fächerByKlassenstufe
                              }
                            , Cmd.none
                            )

        GotSchulartResponse response ->
            ( if Just response.bundesland == model.bundesland then
                { model | availableSchulart = response.schulart }

              else
                model
            , Cmd.none
            )

        GotKlassenstufeResponse response ->
            ( if Just response.bundesland == model.bundesland && Just response.schulart == model.schulart then
                { model | availableKlassenstufe = response.klassenstufe }

              else
                model
            , Cmd.none
            )

        GotFachResponse response ->
            ( if
                Just response.bundesland
                    == model.bundesland
                    && Just response.schulart
                    == model.schulart
                    && Dict.member response.klassenstufe model.fächerByKlassenstufe
              then
                { model
                    | availableFachByKlassenstufe =
                        Dict.insert response.klassenstufe response.fächer model.availableFachByKlassenstufe
                }

              else
                model
            , Cmd.none
            )
