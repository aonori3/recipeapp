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
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(pastRecipesManager.savedRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.title)
                    }
                }
            }
        }
    }
}
