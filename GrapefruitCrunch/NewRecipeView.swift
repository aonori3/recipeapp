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
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .font(.title)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            Text("Let's find a recipe for you!")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top)

            Text("Enter ingredients you already have")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Type your ingredients", text: $currentIngredient)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .padding(.vertical, 12)
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)

            Button(action: {
                addIngredient()
            }) {
                Text("Add Ingredient")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            
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
                Text("Find Recipe")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
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
