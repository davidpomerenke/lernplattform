module Update exposing (update)

import Dict
import Helpers.Data
import Helpers.HttpRequests exposing (makeRequest)
import Json.Decode exposing (field, int, list, string)
import Messages exposing (Msg(..))
import Model exposing (Model, Page(..))
import RemoteData exposing (RemoteData(..))
import Set


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditUserData ->
            case model.user of
                Nothing ->
                    ( model, Cmd.none )

                Just user ->
                    let
                        newModel =
                            { model
                                | page =
                                    Form
                                        { region = Just user.region
                                        , school = Just user.school
                                        , subjectsByClass = user.subjectsByClass
                                        , availableRegions = Success Helpers.Data.availableRegions
                                        , availableSchools = Loading
                                        , availableClasses = Loading
                                        , availableSubjectsByClass = Dict.fromList (List.map (\k -> ( k, Loading )) (Dict.keys user.subjectsByClass))
                                        }
                            }
                    in
                    ( newModel
                    , requestFormData newModel
                    )

        SaveUserData ->
            ( case model.page of
                Content ->
                    model

                Form form ->
                    case form.region of
                        Nothing ->
                            model

                        Just region ->
                            case form.school of
                                Nothing ->
                                    model

                                Just school ->
                                    if List.any (\classes -> Set.size classes > 0) (Dict.values form.subjectsByClass) then
                                        { model
                                            | page = Content
                                            , user =
                                                Just
                                                    { region = region
                                                    , school = school
                                                    , subjectsByClass = form.subjectsByClass
                                                    }
                                        }

                                    else
                                        model
            , Cmd.none
            )

        SetRegion region ->
            ( { model
                | page =
                    case model.page of
                        Content ->
                            Content

                        Form form ->
                            Form
                                { form
                                    | region = Just region
                                    , school = Nothing
                                    , subjectsByClass = Dict.empty
                                    , availableSchools = Loading
                                    , availableClasses = NotAsked
                                    , availableSubjectsByClass = Dict.empty
                                }
              }
            , requestAvailableSchools region
            )

        SetSchool school ->
            case model.page of
                Content ->
                    ( model, Cmd.none )

                Form form ->
                    case form.region of
                        Nothing ->
                            ( model, Cmd.none )

                        Just region ->
                            ( { model
                                | page =
                                    Form
                                        { form
                                            | school = Just school
                                            , subjectsByClass = Dict.empty
                                            , availableClasses = Loading
                                            , availableSubjectsByClass = Dict.empty
                                        }
                              }
                            , requestAvailableClasses region school
                            )

        ToggleClass class ->
            case model.page of
                Content ->
                    ( model, Cmd.none )

                Form form ->
                    case form.region of
                        Nothing ->
                            ( model, Cmd.none )

                        Just region ->
                            case form.school of
                                Nothing ->
                                    ( model, Cmd.none )

                                Just school ->
                                    ( { model
                                        | page =
                                            Form
                                                { form
                                                    | subjectsByClass =
                                                        if Dict.member class form.subjectsByClass then
                                                            Dict.remove class form.subjectsByClass

                                                        else
                                                            Dict.insert class Set.empty form.subjectsByClass
                                                    , availableSubjectsByClass =
                                                        if Dict.member class form.availableSubjectsByClass then
                                                            Dict.remove class form.availableSubjectsByClass

                                                        else
                                                            Dict.insert class Loading form.availableSubjectsByClass
                                                }
                                      }
                                    , if Dict.member class form.subjectsByClass then
                                        Cmd.none

                                      else
                                        requestAvailableSubjects region school class
                                    )

        ToggleSubject ( class, subject ) ->
            case model.page of
                Content ->
                    ( model, Cmd.none )

                Form form ->
                    case form.region of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            case form.school of
                                Nothing ->
                                    ( model, Cmd.none )

                                Just _ ->
                                    ( { model
                                        | page =
                                            Form
                                                { form
                                                    | subjectsByClass =
                                                        Dict.update class
                                                            (\v ->
                                                                case v of
                                                                    Nothing ->
                                                                        Just Set.empty

                                                                    Just subjects ->
                                                                        if Set.member subject subjects then
                                                                            Just (Set.remove subject subjects)

                                                                        else
                                                                            Just (Set.insert subject subjects)
                                                            )
                                                            form.subjectsByClass
                                                }
                                      }
                                    , Cmd.none
                                    )

        GotSchoolResponse response ->
            ( case model.page of
                Content ->
                    model

                Form form ->
                    if Just response.region == form.region then
                        { model | page = Form { form | availableSchools = response.school } }

                    else
                        model
            , Cmd.none
            )

        GotClassResponse response ->
            ( case model.page of
                Content ->
                    model

                Form form ->
                    if Just response.region == form.region && Just response.school == form.school then
                        { model | page = Form { form | availableClasses = response.classes } }

                    else
                        model
            , Cmd.none
            )

        GotSubjectResponse response ->
            ( case model.page of
                Content ->
                    model

                Form form ->
                    if
                        Just response.region
                            == form.region
                            && Just response.school
                            == form.school
                            && Dict.member response.class form.subjectsByClass
                    then
                        { model
                            | page =
                                Form
                                    { form
                                        | availableSubjectsByClass =
                                            Dict.insert response.class response.subjects form.availableSubjectsByClass
                                    }
                        }

                    else
                        model
            , Cmd.none
            )

        HideDevWarning ->
            ( { model | showDevWarning = False }, Cmd.none )


requestFormData : Model -> Cmd Msg
requestFormData model =
    case model.page of
        Content ->
            Cmd.none

        Form form ->
            case form.region of
                Nothing ->
                    Cmd.none

                Just region ->
                    case form.school of
                        Nothing ->
                            requestAvailableSchools region

                        Just school ->
                            Cmd.batch
                                ([ requestAvailableSchools region
                                 , requestAvailableClasses region school
                                 ]
                                    ++ List.map
                                        (\class ->
                                            requestAvailableSubjects
                                                region
                                                school
                                                class
                                        )
                                        (Dict.keys form.subjectsByClass)
                                )


requestAvailableSchools : String -> Cmd Msg
requestAvailableSchools region =
    makeRequest
        ("select distinct school from curriculum where region = '" ++ region ++ "';")
        (list (field "school" string))
        (\school -> GotSchoolResponse { region = region, school = school })


requestAvailableClasses : String -> String -> Cmd Msg
requestAvailableClasses region school =
    makeRequest
        ("select distinct class from curriculum where region = '"
            ++ region
            ++ "' and school = '"
            ++ school
            ++ "';"
        )
        (list (field "class" int))
        (\classes ->
            GotClassResponse
                { region = region
                , school = school
                , classes = classes
                }
        )


requestAvailableSubjects : String -> String -> Int -> Cmd Msg
requestAvailableSubjects region school class =
    makeRequest
        ("select distinct subject from curriculum where region = '"
            ++ region
            ++ "' and school = '"
            ++ school
            ++ "' and class = '"
            ++ String.fromInt class
            ++ "';"
        )
        (list (field "subject" string))
        (\subjects ->
            GotSubjectResponse
                { region = region
                , school = school
                , class = class
                , subjects = subjects
                }
        )
