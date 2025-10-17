import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load recipes from JSON file
const loadRecipes = () => {
  try {
    const jsonPath = path.join(__dirname, 'data', 'recipesSample.json');
    const data = fs.readFileSync(jsonPath, 'utf8');
    const parsed = JSON.parse(data);
    return parsed.recipes || [];
  } catch (error) {
    console.error('Error loading recipes:', error);
    return [];
  }
};

export const resolvers = {
  Query: {
    // Get all recipes
    recipes: () => {
      return loadRecipes();
    },

    // Get a single recipe by title
    recipe: (_, { title }) => {
      const recipes = loadRecipes();
      return recipes.find(recipe => 
        recipe.dynamicTitle.toLowerCase() === title.toLowerCase()
      ) || null;
    },

    // Search recipes by title or description
    searchRecipes: (_, { query }) => {
      const recipes = loadRecipes();
      const searchTerm = query.toLowerCase();
      
      return recipes.filter(recipe => 
        recipe.dynamicTitle.toLowerCase().includes(searchTerm) ||
        recipe.dynamicDescription.toLowerCase().includes(searchTerm)
      );
    },

    // Get random recipes
    randomRecipes: (_, { limit = 4 }) => {
      const recipes = loadRecipes();
      
      // Shuffle array using Fisher-Yates algorithm
      const shuffled = [...recipes];
      for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
      }
      
      // Return requested number of recipes
      return shuffled.slice(0, Math.min(limit, shuffled.length));
    }
  }
};

