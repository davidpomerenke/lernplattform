module Components.Form exposing (form)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Model exposing (HttpStatus(..), Model)
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
                        (klassenstufen model)
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


klassenstufen : Model -> List (Html Msg)
klassenstufen model =
    case model.availableKlassenstufen of
        HttpNotRequested ->
            []

        HttpFailure ->
            [ text "Fehler!" ]

        HttpLoading ->
            [ div [ class "loader" ] [] ]

        HttpSuccess a ->
            a
                |> List.map
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


select : String -> HttpStatus (List String) -> Maybe String -> (String -> Msg) -> Html Msg
select name options value msg =
    Html.select
        [ onInput msg, class "custom-select bg-primary text-white border-0" ]
        (option [ disabled True, selected (value == Nothing) ] [ text name ]
            :: (case options of
                    HttpNotRequested ->
                        []

                    HttpFailure ->
                        [ option [] [ text "Fehler!" ] ]

                    HttpLoading ->
                        [ option [] [ text "Loading ..." ] ]

                    HttpSuccess a ->
                        a
                            |> List.map (\b -> option [ selected (Just b == value) ] [ text b ])
               )
        )
