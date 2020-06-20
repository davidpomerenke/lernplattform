module Messages exposing (Msg(..))

import Graphql.Http
import RemoteData exposing (RemoteData)


type Msg
    = HideDevWarning
    | ShowForm
    | SetBundesland String
    | SetSchulart String
    | ToggleKlassenstufe Int
    | GotSchulartResponse (RemoteData (Graphql.Http.Error (List String)) (List String))
