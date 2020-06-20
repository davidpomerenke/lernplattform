module Helpers.HttpRequests exposing (makeRequest)

import Http
import Json.Decode exposing (Decoder)
import Messages exposing (Msg(..))
import RemoteData exposing (WebData)


makeRequest : String -> Decoder a -> (WebData a -> Msg) -> Cmd Msg
makeRequest request decoder msg =
    Http.post
        { url = "/api/sql"
        , body =
            Http.stringBody "text/plain" request
        , expect = Http.expectJson (RemoteData.fromResult >> msg) decoder
        }
