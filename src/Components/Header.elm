module Components.Header exposing (header)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing(..)
import Messages exposing (Msg(..))
import Model exposing (Model)


header : Model -> Html Msg
header model =
    div []
        [ devWarning model
        , h1 [ class "display-4" ] [ text "Lernplattform" ]
        , p [ class "lead" ]
            [ text "Zum Austauschen von Selbstlern-Material für alle deutschsprachigen Bildungspläne."
            , br [] []
            , text "Für Schüler*innen und Lehrer*innen."
            ]
        ]


devWarning : Model -> Html Msg
devWarning model =
    div
        [ hidden <| not model.showDevWarning
        , class "alert alert-warning alert-dismissible fade show my-1"
        ]
        [ text "Die Plattform befindet sich noch in der Entwicklung und ist nicht voll funktionstüchtig."
        , button [ class "close", onClick HideDevWarning ]
            [ span [] [ text "×" ] ]
        ]
