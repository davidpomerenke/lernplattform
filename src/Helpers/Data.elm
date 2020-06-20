module Helpers.Data exposing (availableBundesland, schulartenOrder)

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
    , "Gymnasium"

    -- etc
    ]
