import Foundation
import SwiftUI

@MainActor
class RecipeLoader: ObservableObject {
    enum LoadState {
        case idle
        case loading
        case loaded([Recipe])
        case failed(String)
    }
    
    @Published var state: LoadState = .idle
    
    // Service dependency - defaults to singleton, can be injected for testing
    private let recipeService: RecipeServiceProtocol
    
    // Hybrid approach: default to singleton, allow injection
    init(recipeService: RecipeServiceProtocol = RecipeService.shared) {
        self.recipeService = recipeService
    }
    
    var recipes: [Recipe] {
        if case .loaded(let recipes) = state {
            return recipes
        }
        return []
    }
    
    var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }
    
    var errorMessage: String? {
        if case .failed(let message) = state {
            return message
        }
        return nil
    }
    
    func loadRecipes() async {
        state = .loading
        
        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            state = .loaded(fetchedRecipes)
        } catch RecipeServiceError.fileNotFound {
            state = .failed("Recipe data file not found")
        } catch RecipeServiceError.decodingError(let error) {
            state = .failed("Failed to decode recipes: \(error.localizedDescription)")
        } catch RecipeServiceError.networkError(let error) {
            state = .failed("Network error: \(error.localizedDescription)")
        } catch {
            state = .failed("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    func retry() async {
        await loadRecipes()
    }
    
    func reset() {
        state = .idle
    }
}

