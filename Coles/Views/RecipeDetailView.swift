import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    private let baseURL = "https://www.coles.com.au"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text(recipe.dynamicTitle)
                    .font(.custom("Poppins-SemiBold", size: 36))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 50)
                
                // Description
                Text(recipe.dynamicDescription)
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 20)
                
                // Recipe Image
                RemoteImage(url: baseURL + recipe.dynamicThumbnail) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                        )
                        .aspectRatio(5/3, contentMode: .fit)
                } errorView: { error in
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            VStack(spacing: 8) {
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                                Text("Image unavailable")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        )
                        .aspectRatio(5/3, contentMode: .fit)
                }
                .aspectRatio(5/3, contentMode: .fit)
                
                // Recipe Info Bar
                RecipeInfoBar(recipeDetails: recipe.recipeDetails)
                
                // Ingredients Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Ingredients")
                        .font(.custom("Poppins-SemiBold", size: 24))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(recipe.ingredients.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(.top, 2)
                                
                                Text(recipe.ingredients[index].ingredient)
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
    }
}

#Preview {
    let sampleRecipe = Recipe(
        dynamicTitle: "Curtis Stone's tomato and bread salad with BBQ eggplant and capsicum",
        dynamicDescription: "For a crowd-pleasing salad, try this tasty combination of fresh tomato, crunchy bread and BBQ veggies. It's topped with fresh basil and oregano for a finishing touch.",
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
        ingredients: [
            Ingredient(ingredient: "1 cup (250ml) extra virgin olive oil, divided"),
            Ingredient(ingredient: "4 cups (240g) 2cm-pieces day-old Coles Bakery Stone Baked by Laurent Pane Di Casa"),
            Ingredient(ingredient: "4 Lebanese eggplants, halved lengthways"),
            Ingredient(ingredient: "1 red capsicum, quartered, seeded"),
            Ingredient(ingredient: "1 yellow capsicum, quartered, seeded")
        ]
    )
    
    return RecipeDetailView(recipe: sampleRecipe)
}

