//
//  RecipeGeneratorView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import Foundation
import SwiftUI


struct RecipeGeneratorView: View {
    var ingredients: [String]
    @State private var recipe: Recipe?
    @State private var isLoading = true
    @State private var recipeText: String? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Recipes for You")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
            .padding()

            if isLoading {
                ProgressView("Fetching Recipes...")
                    .padding()
            } else if let recipeText = recipeText {
                VStack(spacing: 20) {
                    // Button to navigate to the RecipeDetailView
                    NavigationLink(destination: RecipeDetailView(recipeText: recipeText)) {
                        Text("\(extractRecipeTitle(from: recipeText))")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                }
            } else {
                Text("Failed to fetch recipes.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            fetchRecipes()
        }
    }

    func fetchRecipes() {
        print("Fetching recipes...")
        RecipeNetworkManager().generateRecipe(ingredients: ingredients) { fetchedRecipe in
            DispatchQueue.main.async {
                if let recipe = fetchedRecipe {
                    print("\(recipe)")
                    self.recipeText = recipe
                    self.isLoading = false
                } else {
                    print("Failed to fetch recipe: nil response")
                    self.recipeText = "Failed to generate recipe."
                    self.isLoading = false
                }
            }
        }
    }
    func extractRecipeTitle(from recipeText: String) -> String {
        // Assuming the recipe title is between "**" markers
        if let startRange = recipeText.range(of: "**"),
           let endRange = recipeText.range(of: "**", range: startRange.upperBound..<recipeText.endIndex) {
            let title = recipeText[startRange.upperBound..<endRange.lowerBound]
            return String(title).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return "Unnamed Recipe"
    }
}


struct RecipeCardView: View {
    var recipeText: String

    var body: some View {
        VStack(alignment: .leading) {
            // Assuming you have a way to extract an image URL or placeholder text from `recipeText`.
            // If you don't, you might need to extract it before passing `recipeText` to this view.
            // For now, let's just show the recipe title.
            if let titleRange = recipeText.range(of: "**"), let endTitleRange = recipeText.range(of: "**", range: titleRange.upperBound..<recipeText.endIndex) {
                let title = String(recipeText[titleRange.upperBound..<endTitleRange.lowerBound])
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.top, 10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
