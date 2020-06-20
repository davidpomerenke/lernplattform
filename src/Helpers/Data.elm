module Helpers.Data exposing (availableBundesland, compareSchularten)

import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)



-- hardcoded because it should be loaded immediately
-- whereas other data needs only be available after some user interaction


availableBundesland : List String
availableBundesland =
    [ "Baden-Württemberg"
    , "Bayern"
    ]



-- ordering for lists of different Schulart
-- hardcoded because it is easier to implement as an Elm list
-- than it is to implement as an SQL table


schulartenOrder : List String
schulartenOrder =
    [ "Grundschule"
    , "Hauptschule"
    , "Werkrealschule"
    , "Realschule (Grundlegendes Niveau)"
    , "Realschule (Mittleres Niveau)"
    , "Realschule"
    , "Wirtschaftsschule"
    , "Fachoberschule"
    , "Berufsoberschule"
    , "Gymnasium"
    , "Gemeinschaftsschule (Grundlegendes Niveau)"
    , "Gemeinschaftsschule (Mittleres Niveau)"
    , "Gemeinschaftsschule (Erweitertes Niveau)"
    , "Gemeinschaftsschule (Oberstufe)"
    , "Förderschule emotionale und soziale Entwicklung"
    , "Förderschule geistige Entwicklung"
    , "Förderschule Hören"
    , "Förderschule körperliche und motorische Entwicklung"
    , "Förderschule Lernen"
    , "Förderschule Sehen"
    , "Förderschule Sprache"
    ]


compareSchularten : String -> String -> Order
compareSchularten a b =
    compare
        (withDefault 0 (elemIndex a schulartenOrder))
        (withDefault 1 (elemIndex b schulartenOrder))
