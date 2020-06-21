module Messages exposing (Msg(..))

import RemoteData exposing (WebData)


type Msg
    = HideDevWarning
    | ShowForm
    | SetBundesland String
    | SetSchulart String
    | ToggleKlassenstufe Int
    | ToggleFach ( Int, String )
    | GotSchulartResponse { bundesland : String, schulart : WebData (List String) }
    | GotKlassenstufeResponse { bundesland : String, schulart : String, klassenstufe : WebData (List Int) }
    | GotFachResponse { bundesland : String, schulart : String, klassenstufe : Int, fächer : WebData (List String) }
