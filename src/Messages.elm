module Messages exposing (Msg(..))

import RemoteData exposing (WebData)


type Msg
    = EditUserData
    | SaveUserData
    | SetRegion String
    | SetSchool String
    | ToggleClass Int
    | ToggleSubject ( Int, String )
    | GotSchoolResponse
        { region : String
        , school : WebData (List String)
        }
    | GotClassResponse
        { region : String
        , school : String
        , classes : WebData (List Int)
        }
    | GotSubjectResponse
        { region : String
        , school : String
        , class : Int
        , subjects : WebData (List String)
        }
    | HideDevWarning
