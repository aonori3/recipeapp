//
//  PastRecipesVIew.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import Foundation
import SwiftUI

struct PastRecipesView: View {
    @EnvironmentObject var pastRecipesManager: PastRecipesManager

    var body: some View {
        VStack {
            Text("Saved Recipes")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top, 20)

            List {
                ForEach(pastRecipesManager.savedRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipeText: recipe.title)) {
                        Text(recipe.title)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                    }
                }
                .onDelete(perform: deleteRecipe) // Enable swipe-to-delete
            }
        }
    }

    private func deleteRecipe(at offsets: IndexSet) {
        pastRecipesManager.savedRecipes.remove(atOffsets: offsets)
    }
}
