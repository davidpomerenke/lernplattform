module View exposing (view)

import Components.Content
import Components.Footer
import Components.Form
import Components.Header
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg)
import Model exposing (Model)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ Components.Header.header model
        , Components.Form.form model
        , Components.Content.content model
        , Components.Footer.footer
        ]
