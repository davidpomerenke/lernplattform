module Messages exposing (Msg(..))

import RemoteData exposing (WebData)


type Msg
    = HideDevWarning
    | ShowForm
    | SetBundesland String
    | SetSchulart String
    | ToggleKlassenstufe Int
    | GotSchulartResponse (WebData (List String))
    | GotKlassenstufeResponse (WebData (List Int))
