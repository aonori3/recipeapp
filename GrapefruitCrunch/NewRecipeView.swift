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
            Spacer()
            Text("Let's Find You a New Recipe")
                .font(.title)
                .padding(.bottom, 20)
            
            TextField("Enter ingredients", text: $currentIngredient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                if !currentIngredient.isEmpty {
                    ingredients.append(currentIngredient)
                    currentIngredient = ""
                }
            }) {
                Text("Add Ingredient")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)

            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }
            .frame(height: 200)

            Spacer()
            
            NavigationLink(destination: RecipeGeneratorView(ingredients: ingredients)) {
                Text("Find Recipes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()

            // Bottom Navigation Icons
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
            .foregroundColor(.purple)
        }
    }
}
