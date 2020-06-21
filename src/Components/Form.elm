module Components.Form exposing (form)

import Components.Loader exposing (withLoader)
import Dict
import Helpers.Data exposing (compareSchularten)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RemoteData exposing (RemoteData(..), WebData)
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
                        [ class "col-auto my-2" ]
                        [ schulart model ]
                    , div
                        [ class "btn-group col-auto my-2" ]
                        [ klassenstufen model ]
                    ]
                , fächer model
                , if List.any (\fächer_ -> Set.size fächer_ > 0) (Dict.values model.fächerByKlassenstufe) then
                    button
                        [ class "btn btn-success my-2" ]
                        [ text "Material anzeigen" ]

                  else
                    text ""
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
    withLoader model.availableKlassenstufe
        (\availableKlassenstufe ->
            div [ class "btn-group" ]
                (availableKlassenstufe
                    |> List.sort
                    |> List.map
                        (\b ->
                            button
                                [ onClick (ToggleKlassenstufe b)
                                , class
                                    ("klassenstufe btn btn-light border border-primary "
                                        ++ (if Dict.member b model.fächerByKlassenstufe then
                                                "bg-primary text-white"

                                            else
                                                "text-primary"
                                           )
                                    )
                                ]
                                [ text (String.fromInt b) ]
                        )
                )
        )


select :
    String
    -> WebData (List String)
    -> Maybe String
    -> (String -> Msg)
    -> Html Msg
select name options val msg =
    withLoader options
        (\options_ ->
            Html.select
                [ onInput msg, class "custom-select bg-primary text-white border-0" ]
                ([ option [ hidden True, selected (val == Nothing) ] [ text name ]
                 , option [ disabled True ] [ text name ]
                 ]
                    ++ List.map (\b -> option [ selected (Just b == val) ] [ text b ])
                        (List.sortWith compareSchularten options_)
                )
        )


fächer : Model -> Html Msg
fächer model =
    div []
        (List.map
            (\klassenstufe ->
                withLoader
                    (Maybe.withDefault NotAsked
                        (Dict.get klassenstufe model.availableFachByKlassenstufe)
                    )
                    (\fächer_ ->
                        div
                            [ class
                                (if Dict.size model.availableFachByKlassenstufe > 1 then
                                    "border rounded-lg my-2 p-4"

                                 else
                                    ""
                                )
                            ]
                            ([ if Dict.size model.availableFachByKlassenstufe > 1 then
                                h5 [] [ text (String.fromInt klassenstufe ++ ". Klasse") ]

                               else
                                text ""
                             ]
                                ++ (fächer_
                                        |> List.sort
                                        |> List.map
                                            (\fach ->
                                                button
                                                    [ onClick (ToggleFach ( klassenstufe, fach ))
                                                    , class
                                                        ("fach btn btn-outline-primary rounded-pill my-2 mr-2 py-1 px-3"
                                                            ++ (if
                                                                    Set.member fach
                                                                        (Maybe.withDefault Set.empty
                                                                            (Dict.get klassenstufe model.fächerByKlassenstufe)
                                                                        )
                                                                then
                                                                    " bg-primary text-light"

                                                                else
                                                                    ""
                                                               )
                                                        )
                                                    ]
                                                    [ text fach ]
                                            )
                                   )
                            )
                    )
            )
            (Dict.keys model.availableFachByKlassenstufe)
        )
