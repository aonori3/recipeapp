//
//  RecipeDetailView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import Foundation
import SwiftUI


struct RecipeDetailView: View {
    var recipeText: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Extract the title
                if let titleRange = recipeText.range(of: "**") {
                    let title = recipeText[..<titleRange.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                        .padding(.bottom, 10)
                }

                // Extract the ingredients
                if let ingredientsRange = recipeText.range(of: "*Ingredients:*") {
                    let ingredients = recipeText[ingredientsRange.upperBound...].components(separatedBy: "*Instructions:*")[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(Color.purple)
                    Text(ingredients)
                        .padding(.bottom, 10)
                }

                // Extract the instructions
                if let instructionsRange = recipeText.range(of: "*Instructions:*") {
                    let instructions = recipeText[instructionsRange.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines)
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(Color.purple)
                    Text(instructions)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
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
