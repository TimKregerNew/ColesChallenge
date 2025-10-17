import Foundation

enum RecipeServiceError: Error {
    case fileNotFound
    case decodingError(Error)
    case networkError(Error)
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

// Protocol for testability and flexibility
protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
    func fetchRecipe(at index: Int) async throws -> Recipe
    func searchRecipes(query: String) async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    static let shared = RecipeService()  // Singleton for convenience
    
    init() {}  // Init for dependency injection
    private let useGraphQL = true
    
    func fetchRecipes() async throws -> [Recipe] {
        if useGraphQL {
            // Fetch from GraphQL server
            do {
                return try await GraphQLRecipeAPI.shared.fetchRecipes()
            } catch {
                // Fallback to local JSON if GraphQL fails
                print("⚠️ GraphQL fetch failed, falling back to local JSON: \(error)")
                return try await fetchRecipesFromJSON()
            }
        } else {
            return try await fetchRecipesFromJSON()
        }
    }
    
    private func fetchRecipesFromJSON() async throws -> [Recipe] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Load from local JSON file (mock API)
        guard let url = Bundle.main.url(forResource: "recipesSample", withExtension: "json") else {
            throw RecipeServiceError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(RecipesResponse.self, from: data)
            return response.recipes
        } catch let error as DecodingError {
            throw RecipeServiceError.decodingError(error)
        } catch {
            throw RecipeServiceError.networkError(error)
        }
    }
    
    func fetchRecipe(at index: Int) async throws -> Recipe {
        let recipes = try await fetchRecipes()
        guard recipes.indices.contains(index) else {
            throw RecipeServiceError.networkError(NSError(
                domain: "RecipeService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Recipe not found at index \(index)"]
            ))
        }
        return recipes[index]
    }
    
    func searchRecipes(query: String) async throws -> [Recipe] {
        let recipes = try await fetchRecipes()
        guard !query.isEmpty else { return recipes }
        
        return recipes.filter { recipe in
            recipe.dynamicTitle.lowercased().contains(query.lowercased())
        }
    }
}

