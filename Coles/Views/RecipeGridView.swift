import SwiftUI

struct RecipeGridView: View {
    let recipes: [Recipe]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(recipes.indices, id: \.self) { index in
                    NavigationLink(destination: RecipeDetailView(recipe: recipes[index], allRecipes: recipes)) {
                        RecipeCard(recipe: recipes[index])
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    let sampleRecipes = [
        Recipe(
            dynamicTitle: "Curtis Stone's tomato and bread salad with BBQ eggplant and capsicum",
            dynamicDescription: "For a crowd-pleasing salad, try this tasty combination of fresh tomato, crunchy bread and BBQ veggies.",
            dynamicThumbnail: "/content/dam/coles/inspire-create/thumbnails/Tomato-and-bread-salad-480x288.jpg",
            dynamicThumbnailAlt: "Tomato, bread and eggplant salad",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 8,
                prepLabel: "Prep",
                prepTime: "15m",
                prepNote: "+ cooling time",
                cookingLabel: "Cooking",
                cookingTime: "15m",
                cookTimeAsMinutes: 15,
                prepTimeAsMinutes: 15
            ),
            ingredients: []
        ),
        Recipe(
            dynamicTitle: "Pork, fennel and sage ragu with polenta",
            dynamicDescription: "Put your slow cooker to work and make this mouth-watering pork ragu.",
            dynamicThumbnail: "/content/dam/coles/inspire-create/thumbnails/Pork-ragu-480x288.jpg",
            dynamicThumbnailAlt: "Pork ragu served on top of polenta",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 8,
                prepLabel: "Prep",
                prepTime: "15m",
                prepNote: "+ cooling time",
                cookingLabel: "Cooking",
                cookingTime: "15m",
                cookTimeAsMinutes: 15,
                prepTimeAsMinutes: 15
            ),
            ingredients: []
        ),
        Recipe(
            dynamicTitle: "Apple and kale panzanella",
            dynamicDescription: "For a wintery spin on a classic dish, try this fresh panzanella salad.",
            dynamicThumbnail: "/content/dam/coles/inspire-create/thumbnails/Panzanella-salad-480x280.jpg",
            dynamicThumbnailAlt: "Roasted carrots, radish, pear, kale and herbs",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 4,
                prepLabel: "Prep",
                prepTime: "20m",
                prepNote: nil,
                cookingLabel: "Cooking",
                cookingTime: "30m",
                cookTimeAsMinutes: 30,
                prepTimeAsMinutes: 20
            ),
            ingredients: []
        ),
        Recipe(
            dynamicTitle: "Cauliflower soup with smoked cheddar",
            dynamicDescription: "Creamy in texture and cheesy in flavour, this cauliflower soup with smoked cheddar is savoury bliss.",
            dynamicThumbnail: "/content/dam/coles/inspire-create/thumbnails/cauliflower-soup--480x288.jpg",
            dynamicThumbnailAlt: "Cauliflower soup served with smoked almond pesto and basil",
            recipeDetails: RecipeDetails(
                amountLabel: "Serves",
                amountNumber: 4,
                prepLabel: "Prep",
                prepTime: "10m",
                prepNote: "+ cooling time",
                cookingLabel: "Cooking",
                cookingTime: "25m",
                cookTimeAsMinutes: 25,
                prepTimeAsMinutes: 10
            ),
            ingredients: []
        )
    ]
    
    RecipeGridView(recipes: sampleRecipes)
}

