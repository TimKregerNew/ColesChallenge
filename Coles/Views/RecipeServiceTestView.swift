import SwiftUI

struct RecipeServiceTestView: View {
    @State private var recipes: [Recipe] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading recipes...")
                } else if let errorMessage = errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("Retry") {
                            Task {
                                await loadRecipes()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                } else if recipes.isEmpty {
                    VStack(spacing: 16) {
                        Text("No recipes loaded")
                            .foregroundColor(.secondary)
                        Button("Load Recipes") {
                            Task {
                                await loadRecipes()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    RecipeGridView(recipes: recipes)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await loadRecipes()
        }
    }
    
    private func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedRecipes = try await RecipeService.shared.fetchRecipes()
            await MainActor.run {
                recipes = fetchedRecipes
                isLoading = false
            }
        } catch RecipeServiceError.fileNotFound {
            await MainActor.run {
                errorMessage = "Recipe data file not found"
                isLoading = false
            }
        } catch RecipeServiceError.decodingError(let error) {
            await MainActor.run {
                errorMessage = "Failed to decode recipes: \(error.localizedDescription)"
                isLoading = false
            }
        } catch RecipeServiceError.networkError(let error) {
            await MainActor.run {
                errorMessage = "Network error: \(error.localizedDescription)"
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Unexpected error: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}

#Preview {
    RecipeServiceTestView()
}

