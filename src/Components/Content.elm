module Components.Content exposing (content)

import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model)


content : Model -> Html Msg
content model =
    div [] [ ]



{-
   div
       [ hidden (Set.isEmpty model.klassenstufen) ]
       [ div
           [ class "border rounded-lg bg-light my-3 p-3 d-flex flex-wrap" ]
           (Set.toList model.klassenstufen
               |> List.map
                   (\klassenstufe ->
                       div []
                           [ h5 [] [ text (String.fromInt klassenstufe ++ ". Klasse") ]
                           , div [] []

                           (case model.auswahlDatenFach of
                                  HttpSuccess a ->
                                      a
                                          |> List.filter (\b -> b.klassenstufe == klassenstufe)
                                          |> List.map .fach
                                          |> List.map
                                              (\fach ->
                                                  button
                                                      [ class "fach btn btn-outline-primary rounded-pill m-2 py-1 px-3" ]
                                                      [ text fach ]
                                              )

                                  HttpLoading ->
                                      [ div [ class "loader" ] [] ]

                                  Model.HttpFailure ->
                                      [ text "Fehler!" ]

                                  Model.HttpNotRequested ->
                                      []
                              )

                           ]
                   )
           )
       ]
-}
{- .map(
     klassenstufe =>
       (auswahl.klassenstufen.length > 1
         ? `<h5>${klassenstufe}. Klasse</h5>`
         : '') +
       `<div class="fach ${klassenstufe}` +
       (auswahl.klassenstufen.length > 1
         ? ' border rounded-lg bg-light my-2">'
         : '">') +
       fächer
         .filter(a => a.klassenstufe === klassenstufe)
         .map(a => a.fach)
         .sort()
         .map(
           fach =>
             '<button type="button" class="fach btn btn-outline-primary rounded-pill m-2 py-1 px-3' +
             (auswahl &&
             'fächer' in auswahl &&
             auswahl.fächer.find(
               b => b.fach === fach && b.klassenstufe === klassenstufe
             )
               ? ' bg-primary text-light'
               : '') +
             `"><small>${fach}</small></button>`
         )
         .join('') +
       '</div>'
   )
-}
