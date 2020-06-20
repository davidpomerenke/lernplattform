-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Database.Object.Material exposing (..)

import Database.Enum.Materialzuordnung_select_column
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
import Json.Decode as Decode


downvotes : SelectionSet Int Database.Object.Material
downvotes =
    Object.selectionForField "Int" "downvotes" [] Decode.int


link : SelectionSet String Database.Object.Material
link =
    Object.selectionForField "String" "link" [] Decode.string


materialart : SelectionSet Database.ScalarCodecs.Ressourcenart Database.Object.Material
materialart =
    Object.selectionForField "ScalarCodecs.Ressourcenart" "materialart" [] (Database.ScalarCodecs.codecs |> Database.Scalar.unwrapCodecs |> .codecRessourcenart |> .decoder)


materialbeschreibung : SelectionSet (Maybe String) Database.Object.Material
materialbeschreibung =
    Object.selectionForField "(Maybe String)" "materialbeschreibung" [] (Decode.string |> Decode.nullable)


materialeintragsdatum : SelectionSet Database.ScalarCodecs.Date Database.Object.Material
materialeintragsdatum =
    Object.selectionForField "ScalarCodecs.Date" "materialeintragsdatum" [] (Database.ScalarCodecs.codecs |> Database.Scalar.unwrapCodecs |> .codecDate |> .decoder)


materialtestdatum : SelectionSet (Maybe Database.ScalarCodecs.Date) Database.Object.Material
materialtestdatum =
    Object.selectionForField "(Maybe ScalarCodecs.Date)" "materialtestdatum" [] (Database.ScalarCodecs.codecs |> Database.Scalar.unwrapCodecs |> .codecDate |> .decoder |> Decode.nullable)


materialtitel : SelectionSet String Database.Object.Material
materialtitel =
    Object.selectionForField "String" "materialtitel" [] Decode.string


type alias MaterialzuordnungsOptionalArguments =
    { distinct_on : OptionalArgument (List Database.Enum.Materialzuordnung_select_column.Materialzuordnung_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Database.InputObject.Materialzuordnung_order_by)
    , where_ : OptionalArgument Database.InputObject.Materialzuordnung_bool_exp
    }


{-| An array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
materialzuordnungs :
    (MaterialzuordnungsOptionalArguments -> MaterialzuordnungsOptionalArguments)
    -> SelectionSet decodesTo Database.Object.Materialzuordnung
    -> SelectionSet (List decodesTo) Database.Object.Material
materialzuordnungs fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Database.Enum.Materialzuordnung_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Database.InputObject.encodeMaterialzuordnung_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Database.InputObject.encodeMaterialzuordnung_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "materialzuordnungs" optionalArgs object_ (identity >> Decode.list)


upvotes : SelectionSet Int Database.Object.Material
upvotes =
    Object.selectionForField "Int" "upvotes" [] Decode.int