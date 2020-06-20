-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Database.Query exposing (..)

import Database.Enum.Lehrplan_intern_select_column
import Database.Enum.Lehrplan_select_column
import Database.Enum.Lehrplandetails_select_column
import Database.Enum.Lehrplanzuordnung_select_column
import Database.Enum.Lernplattform_select_column
import Database.Enum.Material_select_column
import Database.Enum.Materialzuordnung_select_column
import Database.Enum.Module_select_column
import Database.Enum.Modulhierarchie_select_column
import Database.Enum.Schulart_select_column
import Database.Enum.Schulartenbedeutung_select_column
import Database.InputObject
import Database.Interface
import Database.Object
import Database.Scalar
import Database.ScalarCodecs
import Database.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


type alias LehrplanOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Lehrplan_select_column.Lehrplan_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Lehrplan_order_by)
    , where_ : OptionalArgument Database.InputObject.Lehrplan_bool_exp
    }


{-| fetch data from the table: "lehrplan"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
lehrplan :
    (LehrplanOptionalArguments -> LehrplanOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Lehrplan
    -> SelectionSet (List decodesTo) RootQuery
lehrplan fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Lehrplan_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeLehrplan_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeLehrplan_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "lehrplan" optionalArgs object_ (identity >> Decode.list)


type alias LehrplanInternOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Lehrplan_intern_select_column.Lehrplan_intern_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Lehrplan_intern_order_by)
    , where_ : OptionalArgument Database.InputObject.Lehrplan_intern_bool_exp
    }


{-| fetch data from the table: "lehrplan\_intern"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
lehrplan_intern :
    (LehrplanInternOptionalArguments -> LehrplanInternOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Lehrplan_intern
    -> SelectionSet (List decodesTo) RootQuery
lehrplan_intern fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Lehrplan_intern_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeLehrplan_intern_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeLehrplan_intern_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "lehrplan_intern" optionalArgs object_ (identity >> Decode.list)


type alias LehrplandetailsOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Lehrplandetails_select_column.Lehrplandetails_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Lehrplandetails_order_by)
    , where_ : OptionalArgument Database.InputObject.Lehrplandetails_bool_exp
    }


{-| fetch data from the table: "lehrplandetails"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
lehrplandetails :
    (LehrplandetailsOptionalArguments -> LehrplandetailsOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Lehrplandetails
    -> SelectionSet (List decodesTo) RootQuery
lehrplandetails fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Lehrplandetails_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeLehrplandetails_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeLehrplandetails_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "lehrplandetails" optionalArgs object_ (identity >> Decode.list)


type alias LehrplandetailsByPkRequiredArguments =
    { lehrplanid : Int }


{-| fetch data from the table: "lehrplandetails" using primary key columns
-}
lehrplandetails_by_pk :
    LehrplandetailsByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Lehrplandetails
    -> SelectionSet (Maybe decodesTo) RootQuery
lehrplandetails_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "lehrplandetails_by_pk" [ Argument.required "lehrplanid" requiredArgs.lehrplanid Encode.int ] object_ (identity >> Decode.nullable)


type alias LehrplanzuordnungOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Lehrplanzuordnung_select_column.Lehrplanzuordnung_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Lehrplanzuordnung_order_by)
    , where_ : OptionalArgument Database.InputObject.Lehrplanzuordnung_bool_exp
    }


{-| fetch data from the table: "lehrplanzuordnung"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
lehrplanzuordnung :
    (LehrplanzuordnungOptionalArguments -> LehrplanzuordnungOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Lehrplanzuordnung
    -> SelectionSet (List decodesTo) RootQuery
lehrplanzuordnung fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Lehrplanzuordnung_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeLehrplanzuordnung_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeLehrplanzuordnung_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "lehrplanzuordnung" optionalArgs object_ (identity >> Decode.list)


type alias LehrplanzuordnungByPkRequiredArguments =
    { lehrplanid : Int
    , modul : String
    }


{-| fetch data from the table: "lehrplanzuordnung" using primary key columns
-}
lehrplanzuordnung_by_pk :
    LehrplanzuordnungByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Lehrplanzuordnung
    -> SelectionSet (Maybe decodesTo) RootQuery
lehrplanzuordnung_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "lehrplanzuordnung_by_pk" [ Argument.required "lehrplanid" requiredArgs.lehrplanid Encode.int, Argument.required "modul" requiredArgs.modul Encode.string ] object_ (identity >> Decode.nullable)


type alias LernplattformOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Lernplattform_select_column.Lernplattform_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Lernplattform_order_by)
    , where_ : OptionalArgument Database.InputObject.Lernplattform_bool_exp
    }


{-| fetch data from the table: "lernplattform"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
lernplattform :
    (LernplattformOptionalArguments -> LernplattformOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Lernplattform
    -> SelectionSet (List decodesTo) RootQuery
lernplattform fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Lernplattform_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeLernplattform_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeLernplattform_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "lernplattform" optionalArgs object_ (identity >> Decode.list)


type alias MaterialOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Material_select_column.Material_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Material_order_by)
    , where_ : OptionalArgument Database.InputObject.Material_bool_exp
    }


{-| fetch data from the table: "material"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
material :
    (MaterialOptionalArguments -> MaterialOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Material
    -> SelectionSet (List decodesTo) RootQuery
material fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Material_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeMaterial_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeMaterial_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "material" optionalArgs object_ (identity >> Decode.list)


type alias MaterialByPkRequiredArguments =
    { link : String }


{-| fetch data from the table: "material" using primary key columns
-}
material_by_pk :
    MaterialByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Material
    -> SelectionSet (Maybe decodesTo) RootQuery
material_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "material_by_pk" [ Argument.required "link" requiredArgs.link Encode.string ] object_ (identity >> Decode.nullable)


type alias MaterialzuordnungOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Materialzuordnung_select_column.Materialzuordnung_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Materialzuordnung_order_by)
    , where_ : OptionalArgument Database.InputObject.Materialzuordnung_bool_exp
    }


{-| fetch data from the table: "materialzuordnung"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
materialzuordnung :
    (MaterialzuordnungOptionalArguments -> MaterialzuordnungOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Materialzuordnung
    -> SelectionSet (List decodesTo) RootQuery
materialzuordnung fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Materialzuordnung_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeMaterialzuordnung_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeMaterialzuordnung_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "materialzuordnung" optionalArgs object_ (identity >> Decode.list)


type alias MaterialzuordnungByPkRequiredArguments =
    { link : String
    , modul : String
    }


{-| fetch data from the table: "materialzuordnung" using primary key columns
-}
materialzuordnung_by_pk :
    MaterialzuordnungByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Materialzuordnung
    -> SelectionSet (Maybe decodesTo) RootQuery
materialzuordnung_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "materialzuordnung_by_pk" [ Argument.required "link" requiredArgs.link Encode.string, Argument.required "modul" requiredArgs.modul Encode.string ] object_ (identity >> Decode.nullable)


type alias ModuleOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Module_select_column.Module_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Module_order_by)
    , where_ : OptionalArgument Database.InputObject.Module_bool_exp
    }


{-| fetch data from the table: "module"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
module_ :
    (ModuleOptionalArguments -> ModuleOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Module
    -> SelectionSet (List decodesTo) RootQuery
module_ fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Module_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeModule_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeModule_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "module" optionalArgs object_ (identity >> Decode.list)


type alias ModuleByPkRequiredArguments =
    { modul : String }


{-| fetch data from the table: "module" using primary key columns
-}
module_by_pk :
    ModuleByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Module
    -> SelectionSet (Maybe decodesTo) RootQuery
module_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "module_by_pk" [ Argument.required "modul" requiredArgs.modul Encode.string ] object_ (identity >> Decode.nullable)


type alias ModulhierarchieOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Modulhierarchie_select_column.Modulhierarchie_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Modulhierarchie_order_by)
    , where_ : OptionalArgument Database.InputObject.Modulhierarchie_bool_exp
    }


{-| fetch data from the table: "modulhierarchie"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
modulhierarchie :
    (ModulhierarchieOptionalArguments -> ModulhierarchieOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Modulhierarchie
    -> SelectionSet (List decodesTo) RootQuery
modulhierarchie fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Modulhierarchie_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeModulhierarchie_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeModulhierarchie_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "modulhierarchie" optionalArgs object_ (identity >> Decode.list)


type alias SchulartOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Schulart_select_column.Schulart_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Schulart_order_by)
    , where_ : OptionalArgument Database.InputObject.Schulart_bool_exp
    }


{-| fetch data from the table: "schulart"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
schulart :
    (SchulartOptionalArguments -> SchulartOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Schulart
    -> SelectionSet (List decodesTo) RootQuery
schulart fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Schulart_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeSchulart_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeSchulart_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "schulart" optionalArgs object_ (identity >> Decode.list)


type alias SchulartenbedeutungOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Schulartenbedeutung_select_column.Schulartenbedeutung_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Schulartenbedeutung_order_by)
    , where_ : OptionalArgument Database.InputObject.Schulartenbedeutung_bool_exp
    }


{-| fetch data from the table: "schulartenbedeutung"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
schulartenbedeutung :
    (SchulartenbedeutungOptionalArguments -> SchulartenbedeutungOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Schulartenbedeutung
    -> SelectionSet (List decodesTo) RootQuery
schulartenbedeutung fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Schulartenbedeutung_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeSchulartenbedeutung_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeSchulartenbedeutung_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "schulartenbedeutung" optionalArgs object_ (identity >> Decode.list)


type alias SchulartenbedeutungByPkRequiredArguments =
    { bundesland : Database.ScalarCodecs.Bundesland
    , schulart : String
    }


{-| fetch data from the table: "schulartenbedeutung" using primary key columns
-}
schulartenbedeutung_by_pk :
    SchulartenbedeutungByPkRequiredArguments
    -> SelectionSet decodesTo Database.Object.Schulartenbedeutung
    -> SelectionSet (Maybe decodesTo) RootQuery
schulartenbedeutung_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "schulartenbedeutung_by_pk" [ Argument.required "bundesland" requiredArgs.bundesland (Database.ScalarCodecs.codecs |> Database.Scalar.unwrapEncoder .codecBundesland), Argument.required "schulart" requiredArgs.schulart Encode.string ] object_ (identity >> Decode.nullable)
