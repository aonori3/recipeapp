//
//  NewRecipeView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import Foundation
import SwiftUI


struct NewRecipeView: View {
    @State private var ingredients: [String] = []
    @State private var currentIngredient = ""

    var body: some View {
        VStack {
            Text("Let's Find You a New Recipe")
                .font(.title)
                .padding(.bottom, 20)
            
            TextField("Enter ingredients", text: $currentIngredient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                addIngredient()
            }) {
                Text("Add Ingredient")
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)

            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient)
                        Spacer()
                        Button(action: {
                            deleteIngredient(ingredient)
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .frame(height: 200)

            Spacer()
            
            NavigationLink(destination: RecipeGeneratorView(ingredients: ingredients)) {
                Text("Find Recipes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
    }

    private func addIngredient() {
        guard !currentIngredient.isEmpty else { return }
        ingredients.append(currentIngredient)
        currentIngredient = ""
    }

    private func deleteIngredient(_ ingredient: String) {
        if let index = ingredients.firstIndex(of: ingredient) {
            ingredients.remove(at: index)
        }
    }
}
