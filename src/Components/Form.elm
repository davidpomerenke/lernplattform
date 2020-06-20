module Components.Form exposing (form)

import Components.Loader exposing (withLoader)
import Graphql.Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RemoteData exposing (RemoteData(..))
import Set


form : Model -> Html Msg
form model =
    div
        []
        [ if model.showForm then
            div [ id "auswahl" ]
                [ div [ class "form-row" ]
                    [ div
                        [ class "col-auto my-2" ]
                        [ bundesland model ]
                    , div
                        [ hidden (model.bundesland == Nothing), class "col-auto my-2" ]
                        [ schulart model ]
                    , div
                        [ hidden (model.schulart == Nothing), class "btn-group col-auto my-2" ]
                        [ klassenstufen model ]
                    ]
                , button
                    [ class "btn btn-success my-2" ]
                    [ text "Material anzeigen" ]
                , div
                    [ hidden True, class "alert alert-success p-2" ]
                    [ text "Die Auswahl wurde erfolgreich im Browser gespeichert." ]
                ]

          else
            text ""
        , button
            [ onClick ShowForm, hidden model.showForm, class "btn btn-warning my-2" ]
            [ text "Auswahl ändern" ]
        ]


bundesland : Model -> Html Msg
bundesland model =
    select "Bundesland" model.availableBundesland model.bundesland SetBundesland


schulart : Model -> Html Msg
schulart model =
    select "Schulart" model.availableSchulart model.schulart SetSchulart


klassenstufen : Model -> Html Msg
klassenstufen model =
    withLoader model.availableKlassenstufen
        (\availableKlassenstufen ->
            div []
                (List.map
                    (\b ->
                        button
                            [ onClick (ToggleKlassenstufe b)
                            , class
                                ("klassenstufe btn btn-light border border-primary "
                                    ++ (if Set.member b model.klassenstufen then
                                            "bg-primary text-white"

                                        else
                                            "text-primary"
                                       )
                                )
                            ]
                            [ text (String.fromInt b) ]
                    )
                    availableKlassenstufen
                )
        )


select : String -> RemoteData (Graphql.Http.Error (List String)) (List String) -> Maybe String -> (String -> Msg) -> Html Msg
select name options val msg =
    withLoader options
        (\options_ ->
            Html.select
                [ onInput msg, class "custom-select bg-primary text-white border-0" ]
                ([ option [ hidden True, selected (val == Nothing) ] [ text name ]
                 , option [ disabled True ] [ text name ]
                 ]
                    ++ List.map (\b -> option [ selected (Just b == val) ] [ text b ]) options_
                )
        )
