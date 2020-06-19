module Messages exposing (Msg(..))


type Msg
    = HideDevWarning
    | ShowForm
    | SetBundesland String
    | SetSchulart String
    | ToggleKlassenstufe Int
