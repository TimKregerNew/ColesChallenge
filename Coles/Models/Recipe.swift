//
//  Recipe.swift
//  Coles
//
//  Created by Tim Kreger on 16/10/2025.
//

import Foundation

struct Recipe: Codable, Sendable {
    let dynamicTitle: String
    let dynamicDescription: String
    let dynamicThumbnail: String
    let dynamicThumbnailAlt: String
    let recipeDetails: RecipeDetails
    let ingredients: [Ingredient]
}

public struct RecipeDetails: Codable {
    public let amountLabel: String
    public let amountNumber: Int
    public let prepLabel: String
    public let prepTime: String
    public let prepNote: String?
    public let cookingLabel: String
    public let cookingTime: String
    public let cookTimeAsMinutes: Int
    let prepTimeAsMinutes: Int
    
    init(amountLabel: String, amountNumber: Int, prepLabel: String, prepTime: String, prepNote: String?, cookingLabel: String, cookingTime: String, cookTimeAsMinutes: Int, prepTimeAsMinutes: Int) {
        self.amountLabel = amountLabel
        self.amountNumber = amountNumber
        self.prepLabel = prepLabel
        self.prepTime = prepTime
        self.prepNote = prepNote
        self.cookingLabel = cookingLabel
        self.cookingTime = cookingTime
        self.cookTimeAsMinutes = cookTimeAsMinutes
        self.prepTimeAsMinutes = prepTimeAsMinutes
    }
}

public struct Ingredient: Codable {
    let ingredient: String
    
    init(ingredient: String) {
        self.ingredient = ingredient
    }
}

