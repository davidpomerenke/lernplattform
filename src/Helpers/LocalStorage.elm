port module Helpers.LocalStorage exposing (initWithStorage, updateWithStorage)

import Json.Decode as D
import Json.Decode.Extra as D
import Json.Encode as E
import Messages exposing (Msg)
import Model exposing (Model, Page(..), User)
import RemoteData exposing (RemoteData(..))
import Update exposing (update)


initWithStorage : Model -> List (Cmd Msg) -> D.Value -> ( Model, Cmd Msg )
initWithStorage initialModel commands flags =
    ( -- try to read from local storage
      case D.decodeValue decoder flags of
        Ok m ->
            m

        Err _ ->
            initialModel
    , Cmd.batch commands
    )



-- PORTS
-- save model on update


port setStorage : E.Value -> Cmd msg


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg oldModel =
    let
        ( newModel, cmds ) =
            update msg oldModel
    in
    ( newModel
    , Cmd.batch [ setStorage (encode newModel), cmds ]
    )



-- JSON ENCODE/DECODE
-- local storage <-> model


encode : Model -> E.Value
encode model =
    E.object
        [ ( "user"
          , case model.user of
                Nothing ->
                    E.null

                Just user ->
                    E.object
                        [ ( "region", E.string user.region )
                        , ( "school", E.string user.school )
                        , ( "subjectsByClass", E.dict String.fromInt (E.set E.string) user.subjectsByClass )
                        ]
          )
        , ( "page"
          , case model.page of
                Form _ ->
                    E.string "Form"

                Content ->
                    E.string "Content"
          )
        , ( "showDevWarning", E.bool model.showDevWarning )
        ]


decoder : D.Decoder Model
decoder =
    D.map3 Model
        (D.field "user"
            (D.nullable
                (D.map3 User
                    (D.field "region" D.string)
                    (D.field "school" D.string)
                    (D.field "subjectsByClass" (D.dict2 D.int (D.set D.string)))
                )
            )
        )
        (D.field "page" (D.succeed Content))
        (D.field "showDevWarning" D.bool)
