//
//  MockRecipeService.swift
//  ColesTests
//
//  Created by Tim Kreger on 17/10/2025.
//

import Foundation
@testable import Coles

/// Mock implementation of RecipeServiceProtocol for testing
class MockRecipeService: RecipeServiceProtocol {
    // Configurable mock data
    var mockRecipes: [Recipe] = []
    var shouldFail = false
    var errorToThrow: Error = RecipeServiceError.networkError(
        NSError(domain: "MockRecipeService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
    )
    
    init() {}
    
    func fetchRecipes() async throws -> [Recipe] {
        if shouldFail {
            throw errorToThrow
        }
        return mockRecipes
    }
    
    func fetchRecipe(at index: Int) async throws -> Recipe {
        if shouldFail {
            throw errorToThrow
        }
        
        guard mockRecipes.indices.contains(index) else {
            throw RecipeServiceError.networkError(NSError(
                domain: "MockRecipeService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Recipe not found at index \(index)"]
            ))
        }
        
        return mockRecipes[index]
    }
    
    func searchRecipes(query: String) async throws -> [Recipe] {
        if shouldFail {
            throw errorToThrow
        }
        
        guard !query.isEmpty else { return mockRecipes }
        
        return mockRecipes.filter { recipe in
            recipe.dynamicTitle.lowercased().contains(query.lowercased())
        }
    }
}

