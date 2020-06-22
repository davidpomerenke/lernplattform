module Components.Content exposing (content)

import Components.Loader exposing (withLoader)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RemoteData exposing (RemoteData(..))
import Set


content : Model -> Html Msg
content model =
    div []
        [ button
            [ onClick EditUserData, class "btn btn-warning my-2" ]
            [ text "Auswahl ändern" ]
        , subjects model
        ]


subjects : Model -> Html Msg
subjects model =
    case model.user of
        Nothing ->
            text "Fehler"

        Just user ->
            div []
                (List.map
                    (\class_ ->
                        div
                            []
                            [ h5 [] [ text (String.fromInt class_ ++ ". Klasse") ]
                            , div
                                []
                                (Maybe.withDefault Set.empty
                                    (Dict.get class_ user.subjectsByClass)
                                    |> Set.toList
                                    |> List.sort
                                    |> List.map
                                        (\subject_ -> subject class_ subject_ model)
                                )
                            ]
                    )
                    (Dict.keys user.subjectsByClass)
                )


subject : Int -> String -> Model -> Html Msg
subject class_ subject_ model =
    div [ class "border rounded-lg my-2 p-4" ]
        [ h5 [] [ text subject_ ]
        , div []
            [ div [ class "p-1 d-flex flex-wrap" ]
                [ button
                    [ class "form_title lehrplantitel btn btn-outline-primary rounded-pill m-1 p-0 px-3 abs hierarchie-${hierarchie}"
                    ]
                    [ small [] [ text "Titel" ] ]
                ]
            , div [ class "p-1 d-flex flex-wrap" ]
                [ material ]
            ]
        ]


material : Html Msg
material =
    div [ class "col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3 p-1" ]
        [ div [ class "card", style "height" "100%" ]
            [ div [ class "card-body", style "position" "relative" ]
                [ span [ class "badge badge-info" ]
                    [ text "${material.materialart}" ]
                , h5 [ class "card-title" ]
                    [ text "Titel" ]
                , p [ class "card-text" ]
                    [ text "${material materialbeschreibung}" ]
                , small [ class "text-muted" ]
                    [ a [ href "${material.link}", target "_blank", class "stretched-link" ]
                        [ text "${material.link"

                        --.replace(/https?:\/\/(www\.)?/, '').replace(/\/.*/, '')}"
                        , i [ class "fas fa-external-link-alt" ]
                            []
                        ]
                    ]
                ]
            , div [ class "card-footer d-flex justify-content-between" ]
                [ i
                    [ class "far fa-thumbs-up fa-flip-horizontal text-success"
                    , style "font-size" "x-large"
                    , style "cursor" "pointer"
                    ]
                    []
                , b []
                    [ text "100" ]
                , i
                    [ class "far fa-thumbs-down text-danger"
                    , style "font-size" "x-large"
                    , style "cursor" "pointer"
                    ]
                    []
                ]
            ]
        ]
