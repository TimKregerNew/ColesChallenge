//
//  ContentView.swift
//  Coles
//
//  Created by Tim Kreger on 16/10/2025.
//

import SwiftUI

struct ContentView: View {
    // Determine the orientation using the GeometryReader
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Landscape orientation
                LandscapeView()
            } else {
                // Portrait orientation
                PortraitView()
            }
        }
    }
}

struct PortraitView: View {
    var body: some View {
        Text("Portrait View")
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        
    }
}

struct LandscapeView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
