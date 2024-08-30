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
    @State private var recipes: [Recipe] = []
    @State private var isLoading = true

    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            .padding()

            Text("Recipes for You")
                .font(.title)
                .padding(.bottom, 10)

            if isLoading {
                ProgressView("Fetching Recipes...")
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }
                }
            }
            
            Spacer()

            HStack {
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "magnifyingglass")
                Spacer()
                Image(systemName: "bookmark")
                Spacer()
                Image(systemName: "person.circle")
            }
            .padding()
            .foregroundColor(.pink)
        }
        .onAppear {
            fetchRecipes()
        }
    }

    func fetchRecipes() {
        RecipeNetworkManager().fetchRecipes(ingredients: ingredients) { fetchedRecipes in
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes ?? []
                self.isLoading = false
            }
        }
    }
}

struct RecipeCardView: View {
    var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
                .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(height: 150)
                    .cornerRadius(10)
            }

            Text(recipe.title)
                .font(.headline)
                .padding(.top, 10)

            Text("Short description of the recipe.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
