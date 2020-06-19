module Components.Footer exposing (footer)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))


footer : Html Msg
footer =
    Html.footer
        [ class "footer container text-muted py-2", style "text-align" "center" ]
        [ a
            [ class "btn btn-light border m-2"
            , href "mailto:David Pomerenke<david@lernplattform.wiki>"
            , target "_blank"
            ]
            [ text "Kontakt" ]
        , button
            [ class "btn btn-light border m-2"
            , attribute "data-toggle" "modal"
            , attribute "data-target" "#datenschutz"
            ]
            [ text "Datenschutz" ]
        , a
            [ class "btn btn-light border m-2"
            , href "https://github.com/davidpomerenke/lernplattform"
            , target "_blank"
            ]
            [ text "Github" ]
        , a
            [ class "btn btn-light border m-2"
            , href "https://github.com/davidpomerenke/lernplattform/blob/master/finanzen.md"
            , target "_blank"
            ]
            [ text "Spenden" ]
        , div [ hidden False ] [ datenschutzModal ]
        ]


datenschutzModal : Html Msg
datenschutzModal =
    div [ class "modal fade", id "datenschutz", attribute "tabindex" "-1", attribute "role" "dialog" ]
        [ div
            [ class "modal-dialog", attribute "role" "document" ]
            [ div [ class "modal-content" ]
                [ div
                    [ class "modal-header" ]
                    [ h5 [ class "modal-title" ] [ text "Datenschutz" ]
                    , button [ class "close", attribute "data-dismiss" "modal" ] [ text "×" ]
                    ]
                , div
                    [ class "modal-body" ]
                    [ text "Diese Website schützt die Daten ihrer Nutzer sehr stark:"
                    , br [] []
                    , datenschutzModalText
                    , div [ class "alert alert-success", hidden True ] [ text "Erfolgreich gelöscht." ]
                    ]
                , div
                    [ class "modal-footer justify-content-between" ]
                    [ button [ class "btn btn-danger" ]
                        [ text "Lokale Daten löschen" ]
                    , button [ class "btn btn-info", hidden True ]
                        [ text "Seite neu laden" ]
                    , button [ class "btn btn-secondary", attribute "data-dismiss" "modal" ]
                        [ text "Schließen" ]
                    ]
                ]
            ]
        ]


datenschutzModalText : Html Msg
datenschutzModalText =
    ul []
        [ li []
            [ text "Nutzerdaten werden ausschließlich lokal im Browser der jeweiligen Benutzer*in gespeichert."
            , br [] []
            ]
        , li []
            [ text "Der Betreiber der Website oder irgendwelche Drittparteien haben keinen Zugriff auf die Nutzerdaten."
            , br [] []
            ]
        , li []
            [ text "Das ist transparent und überprüfbar, denn der Code der Website ist "
            , a [ href "https://github.com/davidpomerenke/lernplattform", target "_blank" ]
                [ text "öffentlich" ]
            , text "."
            ]
        ]
