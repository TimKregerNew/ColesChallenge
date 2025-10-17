// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol ColesGraphQL_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ColesGraphQL.SchemaMetadata {}

protocol ColesGraphQL_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ColesGraphQL.SchemaMetadata {}

protocol ColesGraphQL_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ColesGraphQL.SchemaMetadata {}

protocol ColesGraphQL_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ColesGraphQL.SchemaMetadata {}

extension ColesGraphQL {
  typealias SelectionSet = ColesGraphQL_SelectionSet

  typealias InlineFragment = ColesGraphQL_InlineFragment

  typealias MutableSelectionSet = ColesGraphQL_MutableSelectionSet

  typealias MutableInlineFragment = ColesGraphQL_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Ingredient": return ColesGraphQL.Objects.Ingredient
      case "Query": return ColesGraphQL.Objects.Query
      case "Recipe": return ColesGraphQL.Objects.Recipe
      case "RecipeDetails": return ColesGraphQL.Objects.RecipeDetails
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}