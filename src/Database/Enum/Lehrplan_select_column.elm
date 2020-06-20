-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Database.Enum.Lehrplan_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "lehrplan"

  - Bundesland - column name
  - Fach - column name
  - Klassenstufe - column name
  - Lehrplanid - column name
  - Schulart - column name

-}
type Lehrplan_select_column
    = Bundesland
    | Fach
    | Klassenstufe
    | Lehrplanid
    | Schulart


list : List Lehrplan_select_column
list =
    [ Bundesland, Fach, Klassenstufe, Lehrplanid, Schulart ]


decoder : Decoder Lehrplan_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "bundesland" ->
                        Decode.succeed Bundesland

                    "fach" ->
                        Decode.succeed Fach

                    "klassenstufe" ->
                        Decode.succeed Klassenstufe

                    "lehrplanid" ->
                        Decode.succeed Lehrplanid

                    "schulart" ->
                        Decode.succeed Schulart

                    _ ->
                        Decode.fail ("Invalid Lehrplan_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : Lehrplan_select_column -> String
toString enum =
    case enum of
        Bundesland ->
            "bundesland"

        Fach ->
            "fach"

        Klassenstufe ->
            "klassenstufe"

        Lehrplanid ->
            "lehrplanid"

        Schulart ->
            "schulart"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Lehrplan_select_column
fromString enumString =
    case enumString of
        "bundesland" ->
            Just Bundesland

        "fach" ->
            Just Fach

        "klassenstufe" ->
            Just Klassenstufe

        "lehrplanid" ->
            Just Lehrplanid

        "schulart" ->
            Just Schulart

        _ ->
            Nothing