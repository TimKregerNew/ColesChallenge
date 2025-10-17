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

struct RecipeDetails: Codable {
    let amountLabel: String
    let amountNumber: Int
    let prepLabel: String
    let prepTime: String
    let prepNote: String?
    let cookingLabel: String
    let cookingTime: String
    let cookTimeAsMinutes: Int
    let prepTimeAsMinutes: Int
}

struct Ingredient: Codable {
    let ingredient: String
}

