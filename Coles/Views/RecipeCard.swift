import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    private let baseURL = "https://www.coles.com.au"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Recipe Image
            RemoteImage(url: baseURL + recipe.dynamicThumbnail) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                    )
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
            }
            .aspectRatio(5/3, contentMode: .fill)
            .clipped()
            .accessibilityLabel(recipe.dynamicThumbnailAlt)
            
            VStack(alignment: .leading, spacing: 8) {
                // RECIPE Label
                Text("RECIPE")
                    .font(.custom("Poppins-SemiBold", size: 12))
                    .foregroundColor(.red)
                    .tracking(1)
                
                // Recipe Title
                Text(recipe.dynamicTitle)
                    .font(.custom("Poppins-SemiBold", size: 12))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(height: 60, alignment: .top)
            .padding(.bottom, 12)
        }
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    let sampleRecipe = Recipe(
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
    )
    
    return RecipeCard(recipe: sampleRecipe)
        .frame(width: 300)
        .padding()
}

