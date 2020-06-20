module Helpers.GraphqlRequests exposing (makeSchulartRequest)

import Database.InputObject
    exposing
        ( Bundesland_comparison_exp
        , Schulart_bool_exp
        , buildBundesland_comparison_exp
        , buildSchulart_bool_exp
        )
import Database.Object.Schulart as Schulart
import Database.Query as Query exposing (SchulartOptionalArguments)
import Database.Scalar exposing (Bundesland(..))
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Messages exposing (Msg(..))
import RemoteData


makeSchulartRequest : String -> Cmd Msg
makeSchulartRequest bundesland =
    querySchulart bundesland
        |> Graphql.Http.queryRequest "https://lernplattform-graphql.herokuapp.com/v1/graphql"
        |> Graphql.Http.send (RemoteData.fromResult >> GotSchulartResponse)


querySchulart : String -> SelectionSet (List String) RootQuery
querySchulart bundesland =
    Query.schulart (schulartOptionalArgument bundesland) (SelectionSet.nonNullOrFail Schulart.schulart)


equalToBundesland : String -> OptionalArgument Bundesland_comparison_exp
equalToBundesland string =
    Present <| buildBundesland_comparison_exp (\args -> { args | eq_ = Present (Bundesland string) })


whereBundesland : String -> OptionalArgument Schulart_bool_exp
whereBundesland bundesland_ =
    Present <| buildSchulart_bool_exp (\args -> { args | bundesland = equalToBundesland bundesland_ })


schulartOptionalArgument : String -> SchulartOptionalArguments -> SchulartOptionalArguments
schulartOptionalArgument bundesland optionalArgs =
    { optionalArgs | where_ = whereBundesland bundesland }
