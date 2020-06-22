module View exposing (view)

import Components.Content
import Components.Footer
import Components.Form
import Components.Header
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg)
import Model exposing (Model, Page(..))


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ Components.Header.header model
        , case model.page of
            Form form ->
                Components.Form.formView form

            Content ->
                Components.Content.content model
        , Components.Footer.footer
        ]
