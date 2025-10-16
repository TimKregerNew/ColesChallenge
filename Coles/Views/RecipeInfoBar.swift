import SwiftUI

struct RecipeInfoBar: View {
    let recipeDetails: RecipeDetails
    
    var body: some View {
        VStack(spacing: 0) {
            // Top horizontal gray line
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 0.5)
            
            // 10px padding
            Spacer()
                .frame(height: 10)
            
            // Info sections
            HStack(alignment: .center, spacing: 0) {
                // Serves section
                VStack(spacing: 4) {
                    Text(recipeDetails.amountLabel)
                        .font(.custom("Poppins-Regular", size: 14))
                    
                    Text("\(recipeDetails.amountNumber)")
                        .font(.custom("Poppins-SemiBold", size: 18))
                }
                .frame(maxWidth: .infinity)
                
                // Vertical divider
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 0.5, height: 40)
                
                // Prep section
                VStack(spacing: 4) {
                    Text(recipeDetails.prepLabel)
                        .font(.custom("Poppins-Regular", size: 14))
                    
                    Text(recipeDetails.prepTime)
                        .font(.custom("Poppins-SemiBold", size: 18))
                }
                .frame(maxWidth: .infinity)
                
                // Vertical divider
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 0.5, height: 40)
                
                // Cooking section
                VStack(spacing: 4) {
                    Text(recipeDetails.cookingLabel)
                        .font(.custom("Poppins-Regular", size: 14))
                    
                    Text(recipeDetails.cookingTime)
                        .font(.custom("Poppins-SemiBold", size: 18))
                }
                .frame(maxWidth: .infinity)
            }
            
            // 10px padding
            Spacer()
                .frame(height: 10)
            
            // Bottom horizontal gray line
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 0.5)
        }
    }
}

#Preview {
    RecipeInfoBar(recipeDetails: RecipeDetails(
        amountLabel: "Serves",
        amountNumber: 8,
        prepLabel: "Prep",
        prepTime: "15m",
        prepNote: nil,
        cookingLabel: "Cooking",
        cookingTime: "4h 30m",
        cookTimeAsMinutes: 270,
        prepTimeAsMinutes: 15
    ))
    .padding()
}

