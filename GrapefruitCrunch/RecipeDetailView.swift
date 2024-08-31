//
//  RecipeDetailView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var isBookmarked = false  // State to track if the recipe is bookmarked
    @State private var recipeDetails: RecipeDetails?
    @State private var isLoading = true
    @EnvironmentObject var pastRecipesManager: PastRecipesManager

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading recipe details...")
                    .padding()
            } else if let details = recipeDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text(recipe.title)
                                .font(.largeTitle)
                                .padding(.bottom, 10)
                            Spacer()
                            Button(action: {
                                isBookmarked.toggle()  // Toggle bookmark status
                                if isBookmarked {
                                    pastRecipesManager.addRecipe(recipe)
                                } else {
                                    pastRecipesManager.removeRecipe(recipe)
                                }
                            }) {
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")  // Change icon based on state
                                    .foregroundColor(.pink)
                                    .padding()
                            }
                        }

                        if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 200)
                            .cornerRadius(10)
                        }

                        Text("Ingredients")
                            .font(.headline)

                        ForEach(details.extendedIngredients, id: \.id) { ingredient in
                            Text("- \(ingredient.original)")
                        }

                        Text("Instructions")
                            .font(.headline)
                            .padding(.top, 20)

                        ForEach(details.instructions?.split(separator: ".").map(String.init) ?? [], id: \.self) { step in
                            Text(step)
                                .padding(.bottom, 5)
                        }
                    }
                    .padding()
                }
            } else {
                Text("Failed to load recipe details.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            fetchRecipeDetails()
        }
    }
    
    func fetchRecipeDetails() {
        guard let apiKey = ProcessInfo.processInfo.environment["SPOONACULAR_API_KEY"] else {
            fatalError("API key not found")
        }
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(recipe.id)/information?apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            do {
                let details = try JSONDecoder().decode(RecipeDetails.self, from: data)
                DispatchQueue.main.async {
                    self.recipeDetails = details
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

struct RecipeDetails: Codable {
    let id: Int
    let title: String
    let image: String?
    let extendedIngredients: [Ingredient]
    let instructions: String?
    
    struct Ingredient: Codable, Identifiable {
        let id: Int
        let original: String
    }
}
