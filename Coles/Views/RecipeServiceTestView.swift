import SwiftUI

struct RecipeServiceTestView: View {
    @StateObject private var loader = RecipeLoader()
    
    var body: some View {
        NavigationView {
            Group {
                switch loader.state {
                case .idle:
                    VStack(spacing: 16) {
                        Text("Ready to load recipes")
                            .foregroundColor(.secondary)
                        Button("Load Recipes") {
                            Task {
                                await loader.loadRecipes()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                case .loading:
                    ProgressView("Loading recipes...")
                    
                case .failed(let errorMessage):
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
                                await loader.retry()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    
                case .loaded(let recipes):
                    RecipeGridView(recipes: recipes)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await loader.loadRecipes()
        }
    }
}

#Preview {
    RecipeServiceTestView()
}


