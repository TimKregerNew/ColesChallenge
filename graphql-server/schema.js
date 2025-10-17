export const typeDefs = `#graphql
  type Recipe {
    dynamicTitle: String!
    dynamicDescription: String!
    dynamicThumbnail: String!
    dynamicThumbnailAlt: String!
    recipeDetails: RecipeDetails!
    ingredients: [Ingredient!]!
  }

  type RecipeDetails {
    amountLabel: String!
    amountNumber: Int!
    prepLabel: String!
    prepTime: String!
    prepNote: String
    cookingLabel: String!
    cookingTime: String!
    cookTimeAsMinutes: Int!
    prepTimeAsMinutes: Int!
  }

  type Ingredient {
    ingredient: String!
  }

  type Query {
    # Get all recipes
    recipes: [Recipe!]!
    
    # Get a single recipe by title
    recipe(title: String!): Recipe
    
    # Search recipes by title or description
    searchRecipes(query: String!): [Recipe!]!
    
    # Get random recipes with optional limit
    randomRecipes(limit: Int = 4): [Recipe!]!
  }
`;

