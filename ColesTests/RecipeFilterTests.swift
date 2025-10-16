//
//  RecipeFilterTests.swift
//  ColesTests
//
//  Created by Tim Kreger on 16/10/2025.
//

import XCTest
@testable import Coles

class RecipeFilterTests: XCTestCase {
    
    var sampleRecipes: [Recipe] = []
    var currentRecipe: Recipe!
    
    override func setUp() {
        super.setUp()
        
        // Create sample recipes for testing
        sampleRecipes = [
            createRecipe(title: "Recipe 1", thumbnail: "/image1.jpg"),
            createRecipe(title: "Recipe 2", thumbnail: "/image2.jpg"),
            createRecipe(title: "Recipe 3", thumbnail: "/image3.jpg"),
            createRecipe(title: "Recipe 4", thumbnail: "/image4.jpg"),
            createRecipe(title: "Recipe 5", thumbnail: "/image5.jpg"),
            createRecipe(title: "Recipe 6", thumbnail: "/image6.jpg"),
            createRecipe(title: "Recipe 2", thumbnail: "/image2-duplicate.jpg"), // Duplicate
            createRecipe(title: "Recipe 7", thumbnail: "/image7.jpg")
        ]
        
        currentRecipe = sampleRecipes[0] // Recipe 1
    }
    
    // Test that current recipe is excluded from results
    func testCurrentRecipeIsExcluded() {
        let filtered = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 10)
        
        XCTAssertFalse(filtered.contains(where: { $0.dynamicTitle == currentRecipe.dynamicTitle }),
                      "Current recipe should be excluded from results")
    }
    
    // Test that duplicates are removed
    func testDuplicatesAreRemoved() {
        let filtered = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 10)
        
        // Count occurrences of each title
        var titleCounts: [String: Int] = [:]
        for recipe in filtered {
            titleCounts[recipe.dynamicTitle, default: 0] += 1
        }
        
        // Verify no duplicates
        for (title, count) in titleCounts {
            XCTAssertEqual(count, 1, "Recipe '\(title)' appears \(count) times, expected 1")
        }
    }
    
    // Test that results are limited to specified count
    func testResultsAreLimitedToFour() {
        let filtered = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 4)
        
        XCTAssertLessThanOrEqual(filtered.count, 4, "Should return at most 4 recipes")
    }
    
    // Test with fewer recipes than limit
    func testWithFewerRecipesThanLimit() {
        let smallRecipeList = [
            createRecipe(title: "Recipe A", thumbnail: "/imageA.jpg"),
            createRecipe(title: "Recipe B", thumbnail: "/imageB.jpg"),
            createRecipe(title: "Recipe C", thumbnail: "/imageC.jpg")
        ]
        
        let current = smallRecipeList[0]
        let filtered = filterOtherRecipes(currentRecipe: current, allRecipes: smallRecipeList, limit: 4)
        
        XCTAssertEqual(filtered.count, 2, "Should return 2 recipes when only 2 others are available")
    }
    
    // Test with only the current recipe
    func testWithOnlyCurrentRecipe() {
        let singleRecipeList = [currentRecipe!]
        let filtered = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: singleRecipeList, limit: 4)
        
        XCTAssertEqual(filtered.count, 0, "Should return empty array when only current recipe exists")
    }
    
    // Test that all returned recipes are unique
    func testAllReturnedRecipesAreUnique() {
        let filtered = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 4)
        
        let uniqueTitles = Set(filtered.map { $0.dynamicTitle })
        XCTAssertEqual(filtered.count, uniqueTitles.count, "All returned recipes should be unique")
    }
    
    // Test multiple runs produce different results (due to shuffling)
    func testMultipleRunsProduceDifferentResults() {
        let run1 = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 4)
        let run2 = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 4)
        let run3 = filterOtherRecipes(currentRecipe: currentRecipe, allRecipes: sampleRecipes, limit: 4)
        
        // Convert to title arrays for comparison
        let titles1 = run1.map { $0.dynamicTitle }
        let titles2 = run2.map { $0.dynamicTitle }
        let titles3 = run3.map { $0.dynamicTitle }
        
        // At least one run should be different (not guaranteed but highly likely with shuffling)
        let allSame = (titles1 == titles2) && (titles2 == titles3)
        XCTAssertFalse(allSame, "Multiple runs should produce different orderings (due to randomization)")
    }
    
    // MARK: - Helper Methods
    
    /// This replicates the logic from RecipeDetailView.loadOtherRecipes()
    private func filterOtherRecipes(currentRecipe: Recipe, allRecipes: [Recipe], limit: Int) -> [Recipe] {
        // Filter out current recipe and remove duplicates based on title
        var seen = Set<String>()
        let uniqueRecipes = allRecipes.filter { otherRecipe in
            guard otherRecipe.dynamicTitle != currentRecipe.dynamicTitle else { return false }
            if seen.contains(otherRecipe.dynamicTitle) {
                return false
            }
            seen.insert(otherRecipe.dynamicTitle)
            return true
        }
        
        return Array(uniqueRecipes.shuffled().prefix(limit))
    }
    
    private func createRecipe(title: String, thumbnail: String) -> Recipe {
        return Recipe(
            dynamicTitle: title,
            dynamicDescription: "Test description",
            dynamicThumbnail: thumbnail,
            dynamicThumbnailAlt: "Test alt text",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 4,
                prepLabel: "Prep",
                prepTime: "10m",
                prepNote: nil,
                cookingLabel: "Cooking",
                cookingTime: "20m",
                cookTimeAsMinutes: 20,
                prepTimeAsMinutes: 10
            ),
            ingredients: []
        )
    }
}

