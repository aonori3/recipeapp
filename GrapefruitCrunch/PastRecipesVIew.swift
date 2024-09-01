//
//  PastRecipesVIew.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

struct PastRecipesView: View {
    @EnvironmentObject var pastRecipesManager: PastRecipesManager

    var body: some View {
        List {
            ForEach(pastRecipesManager.savedRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteRecipe)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Saved Recipes")
    }

    private func deleteRecipe(at offsets: IndexSet) {
        pastRecipesManager.savedRecipes.remove(atOffsets: offsets)
    }
}
