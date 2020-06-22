module Components.Form exposing (formView)

import Components.Loader exposing (withLoader)
import Dict
import Helpers.Data
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model, FormData)
import RemoteData exposing (RemoteData(..), WebData)
import Set


formView : FormData -> Html Msg
formView form =
    div []
        [ div [ class "form-row" ]
            [ div
                [ class "col-auto my-2" ]
                [ selectRegion form ]
            , div
                [ class "col-auto my-2" ]
                [ selectSchool form ]
            , div
                [ class "btn-group col-auto my-2" ]
                [ selectClasses form ]
            ]
        , selectSubjects form
        , if
            List.any
                (\subjects -> Set.size subjects > 0)
                (Dict.values form.subjectsByClass)
          then
            div []
                [ button
                    [ onClick SaveUserData, class "btn btn-success my-2" ]
                    [ text "Speichern" ]
                , div [] [ text "Die Daten werden nur in Deinem Browser gespeichert, wir haben darauf keinen Zugriff." ]
                ]

          else
            text ""
        ]


selectRegion : FormData -> Html Msg
selectRegion form =
    select "Bundesland" form.availableRegions compare form.region SetRegion


selectSchool : FormData -> Html Msg
selectSchool form =
    select "Schulart" form.availableSchools Helpers.Data.compareSchools form.school SetSchool


selectClasses : FormData -> Html Msg
selectClasses form =
    withLoader form.availableClasses
        (\availableClasses ->
            div [ class "btn-group" ]
                (availableClasses
                    |> List.sort
                    |> List.map
                        (\b ->
                            button
                                [ onClick (ToggleClass b)
                                , class
                                    ("form_class btn btn-light border border-primary "
                                        ++ (if Dict.member b form.subjectsByClass then
                                                "bg-primary text-white"

                                            else
                                                "text-primary"
                                           )
                                    )
                                ]
                                [ text (String.fromInt b) ]
                        )
                )
        )


select :
    String
    -> WebData (List String)
    -> (String -> String -> Order)
    -> Maybe String
    -> (String -> Msg)
    -> Html Msg
select name options comparator val msg =
    withLoader options
        (\options_ ->
            Html.select
                [ onInput msg, class "custom-select bg-primary text-white border-0" ]
                ([ option [ hidden True, selected (val == Nothing) ] [ text name ]
                 , option [ disabled True ] [ text name ]
                 ]
                    ++ List.map (\b -> option [ selected (Just b == val) ] [ text b ])
                        (List.sortWith comparator options_)
                )
        )


selectSubjects : FormData -> Html Msg
selectSubjects form =
    div []
        (List.map
            (\class_ ->
                div
                    [ class
                        (if Dict.size form.availableSubjectsByClass > 1 then
                            "border rounded-lg my-2 p-4"

                         else
                            ""
                        )
                    ]
                    ([ if Dict.size form.availableSubjectsByClass > 1 then
                        h5 [] [ text (String.fromInt class_ ++ ". Klasse") ]

                       else
                        text ""
                     ]
                        ++ [ withLoader
                                (Maybe.withDefault NotAsked
                                    (Dict.get class_ form.availableSubjectsByClass)
                                )
                                (\fächer_ ->
                                    div
                                        []
                                        (fächer_
                                            |> List.sort
                                            |> List.map
                                                (\subject -> buttonSubject class_ subject form)
                                        )
                                )
                           ]
                    )
            )
            (Dict.keys form.availableSubjectsByClass)
        )


buttonSubject : Int -> String -> FormData -> Html Msg
buttonSubject class_ subject form =
    button
        [ onClick (ToggleSubject ( class_, subject ))
        , class
            ("form_subject btn btn-outline-primary rounded-pill my-2 mr-2 py-1 px-3"
                ++ (if
                        Set.member subject
                            (Maybe.withDefault Set.empty
                                (Dict.get class_ form.subjectsByClass)
                            )
                    then
                        " bg-primary text-light"

                    else
                        ""
                   )
            )
        ]
        [ text subject ]
