import Foundation
import Apollo
import ApolloAPI

enum GraphQLRecipeAPIError: Error {
    case networkError(Error)
    case noData
    case mappingError
}

class GraphQLRecipeAPI {
    static let shared = GraphQLRecipeAPI()
    
    // Apollo Client configured to connect to local GraphQL server
    private lazy var apollo: ApolloClient = {
        let url = URL(string: "http://localhost:4000")!
        return ApolloClient(url: url)
    }()
    
    private init() {}
    
    /// Fetch all recipes from GraphQL server
    func fetchRecipes() async throws -> [Recipe] {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: ColesGraphQL.GetAllRecipesQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    if let recipes = graphQLResult.data?.recipes {
                        let mappedRecipes = recipes.compactMap { self.mapToRecipe($0) }
                        continuation.resume(returning: mappedRecipes)
                    } else if let errors = graphQLResult.errors {
                        let errorMessage = errors.first?.message ?? "Unknown GraphQL error"
                        continuation.resume(throwing: GraphQLRecipeAPIError.networkError(
                            NSError(domain: "GraphQL", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        ))
                    } else {
                        continuation.resume(throwing: GraphQLRecipeAPIError.noData)
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: GraphQLRecipeAPIError.networkError(error))
                }
            }
        }
    }
    
    /// Fetch random recipes from GraphQL server
    func fetchRandomRecipes(limit: Int = 4) async throws -> [Recipe] {
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: ColesGraphQL.GetRandomRecipesQuery(limit: .some(limit))) { result in
                switch result {
                case .success(let graphQLResult):
                    if let recipes = graphQLResult.data?.randomRecipes {
                        let mappedRecipes = recipes.compactMap { self.mapToRecipe($0) }
                        continuation.resume(returning: mappedRecipes)
                    } else if let errors = graphQLResult.errors {
                        let errorMessage = errors.first?.message ?? "Unknown GraphQL error"
                        continuation.resume(throwing: GraphQLRecipeAPIError.networkError(
                            NSError(domain: "GraphQL", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        ))
                    } else {
                        continuation.resume(throwing: GraphQLRecipeAPIError.noData)
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: GraphQLRecipeAPIError.networkError(error))
                }
            }
        }
    }
    
    // MARK: - Private Mapping Methods
    
    /// Map GraphQL Recipe type to app's Recipe model
    private func mapToRecipe(_ graphQLRecipe: ColesGraphQL.GetAllRecipesQuery.Data.Recipe) -> Recipe? {
        return Recipe(
            dynamicTitle: graphQLRecipe.dynamicTitle,
            dynamicDescription: graphQLRecipe.dynamicDescription,
            dynamicThumbnail: graphQLRecipe.dynamicThumbnail,
            dynamicThumbnailAlt: graphQLRecipe.dynamicThumbnailAlt,
            recipeDetails: RecipeDetails(
                amountLabel: graphQLRecipe.recipeDetails.amountLabel,
                amountNumber: graphQLRecipe.recipeDetails.amountNumber,
                prepLabel: graphQLRecipe.recipeDetails.prepLabel,
                prepTime: graphQLRecipe.recipeDetails.prepTime,
                prepNote: graphQLRecipe.recipeDetails.prepNote,
                cookingLabel: graphQLRecipe.recipeDetails.cookingLabel,
                cookingTime: graphQLRecipe.recipeDetails.cookingTime,
                cookTimeAsMinutes: graphQLRecipe.recipeDetails.cookTimeAsMinutes,
                prepTimeAsMinutes: graphQLRecipe.recipeDetails.prepTimeAsMinutes
            ),
            ingredients: graphQLRecipe.ingredients.map { Ingredient(ingredient: $0.ingredient) }
        )
    }
    
    /// Map GraphQL Random Recipe type to app's Recipe model
    private func mapToRecipe(_ graphQLRecipe: ColesGraphQL.GetRandomRecipesQuery.Data.RandomRecipe) -> Recipe? {
        return Recipe(
            dynamicTitle: graphQLRecipe.dynamicTitle,
            dynamicDescription: graphQLRecipe.dynamicDescription,
            dynamicThumbnail: graphQLRecipe.dynamicThumbnail,
            dynamicThumbnailAlt: graphQLRecipe.dynamicThumbnailAlt,
            recipeDetails: RecipeDetails(
                amountLabel: graphQLRecipe.recipeDetails.amountLabel,
                amountNumber: graphQLRecipe.recipeDetails.amountNumber,
                prepLabel: graphQLRecipe.recipeDetails.prepLabel,
                prepTime: graphQLRecipe.recipeDetails.prepTime,
                prepNote: graphQLRecipe.recipeDetails.prepNote,
                cookingLabel: graphQLRecipe.recipeDetails.cookingLabel,
                cookingTime: graphQLRecipe.recipeDetails.cookingTime,
                cookTimeAsMinutes: graphQLRecipe.recipeDetails.cookTimeAsMinutes,
                prepTimeAsMinutes: graphQLRecipe.recipeDetails.prepTimeAsMinutes
            ),
            ingredients: graphQLRecipe.ingredients.map { Ingredient(ingredient: $0.ingredient) }
        )
    }
}

