module Components.Loader exposing (withLoader)

import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import RemoteData exposing (RemoteData(..))


withLoader : RemoteData a b -> (b -> Html Msg) -> Html Msg
withLoader dynamicContent html =
    case dynamicContent of
        NotAsked ->
            text ""

        Failure _ ->
            text "Fehler!"

        Loading ->
            div [ class "loader" ] []

        Success a ->
            html a
