//
//  RecipeGeneratorView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

struct RecipeGeneratorView: View {
    var ingredients: [String]
    @State private var recipeText: String?
    @State private var isLoading = true
    @EnvironmentObject var pastRecipesManager: PastRecipesManager
    @State private var showingSavedAlert = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Generating Recipe...")
            } else if let recipeText = recipeText {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(extractRecipeTitle(from: recipeText))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)

                        Text(recipeText)
                            .font(.body)
                    }
                    .padding()
                }
                
                HStack {
                    Button(action: {
                        saveRecipe()
                    }) {
                        Text("Save Recipe")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(20)
                    }

                    Button(action: {
                        fetchRecipe()
                    }) {
                        Text("Generate New Recipe")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(20)
                    }
                }
                .padding()
            } else {
                Text("Failed to fetch recipe.")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Generated Recipe")
        .onAppear {
            fetchRecipe()
        }
        .alert(isPresented: $showingSavedAlert) {
            Alert(title: Text("Recipe Saved"), message: Text("The recipe has been saved successfully."), dismissButton: .default(Text("OK")))
        }
    }

    private func fetchRecipe() {
        isLoading = true
        RecipeNetworkManager().generateRecipe(ingredients: ingredients) { fetchedRecipe in
            DispatchQueue.main.async {
                self.recipeText = fetchedRecipe
                self.isLoading = false
            }
        }
    }

    private func extractRecipeTitle(from recipeText: String) -> String {
        if let range = recipeText.range(of: "**", options: .backwards),
           let startRange = recipeText.range(of: "**") {
            return String(recipeText[startRange.upperBound..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return "Untitled Recipe"
    }

    private func saveRecipe() {
        guard let recipeText = recipeText else { return }
        let newRecipe = Recipe(title: extractRecipeTitle(from: recipeText), ingredients: ingredients, instructions: recipeText)
        pastRecipesManager.addRecipe(newRecipe)
        showingSavedAlert = true
    }
}
