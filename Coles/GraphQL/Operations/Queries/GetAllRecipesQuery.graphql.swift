// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ColesGraphQL {
  class GetAllRecipesQuery: GraphQLQuery {
    static let operationName: String = "GetAllRecipes"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetAllRecipes { recipes { __typename dynamicTitle dynamicDescription dynamicThumbnail dynamicThumbnailAlt recipeDetails { __typename amountLabel amountNumber prepLabel prepTime prepNote cookingLabel cookingTime cookTimeAsMinutes prepTimeAsMinutes } ingredients { __typename ingredient } } }"#
      ))

    public init() {}

    struct Data: ColesGraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { ColesGraphQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("recipes", [Recipe].self),
      ] }

      var recipes: [Recipe] { __data["recipes"] }

      /// Recipe
      ///
      /// Parent Type: `Recipe`
      struct Recipe: ColesGraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { ColesGraphQL.Objects.Recipe }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("dynamicTitle", String.self),
          .field("dynamicDescription", String.self),
          .field("dynamicThumbnail", String.self),
          .field("dynamicThumbnailAlt", String.self),
          .field("recipeDetails", RecipeDetails.self),
          .field("ingredients", [Ingredient].self),
        ] }

        var dynamicTitle: String { __data["dynamicTitle"] }
        var dynamicDescription: String { __data["dynamicDescription"] }
        var dynamicThumbnail: String { __data["dynamicThumbnail"] }
        var dynamicThumbnailAlt: String { __data["dynamicThumbnailAlt"] }
        var recipeDetails: RecipeDetails { __data["recipeDetails"] }
        var ingredients: [Ingredient] { __data["ingredients"] }

        /// Recipe.RecipeDetails
        ///
        /// Parent Type: `RecipeDetails`
        struct RecipeDetails: ColesGraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { ColesGraphQL.Objects.RecipeDetails }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("amountLabel", String.self),
            .field("amountNumber", Int.self),
            .field("prepLabel", String.self),
            .field("prepTime", String.self),
            .field("prepNote", String?.self),
            .field("cookingLabel", String.self),
            .field("cookingTime", String.self),
            .field("cookTimeAsMinutes", Int.self),
            .field("prepTimeAsMinutes", Int.self),
          ] }

          var amountLabel: String { __data["amountLabel"] }
          var amountNumber: Int { __data["amountNumber"] }
          var prepLabel: String { __data["prepLabel"] }
          var prepTime: String { __data["prepTime"] }
          var prepNote: String? { __data["prepNote"] }
          var cookingLabel: String { __data["cookingLabel"] }
          var cookingTime: String { __data["cookingTime"] }
          var cookTimeAsMinutes: Int { __data["cookTimeAsMinutes"] }
          var prepTimeAsMinutes: Int { __data["prepTimeAsMinutes"] }
        }

        /// Recipe.Ingredient
        ///
        /// Parent Type: `Ingredient`
        struct Ingredient: ColesGraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { ColesGraphQL.Objects.Ingredient }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("ingredient", String.self),
          ] }

          var ingredient: String { __data["ingredient"] }
        }
      }
    }
  }

}