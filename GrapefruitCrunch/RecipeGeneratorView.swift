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
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: NewRecipeView()) {
                    Text("Back")
                        .foregroundColor(.purple)
                }
                Spacer()
            }
            .padding()

            Text("Recipes for You")
                .font(.title)
                .padding(.bottom, 10)

            ScrollView {
                VStack(spacing: 20) {
                    // This is just a placeholder for recipe cards
                    ForEach(0..<5) { _ in
                        RecipeCardView()
                    }
                }
            }
            
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

struct RecipeCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "photo")
                .resizable()
                .frame(height: 150)
                .cornerRadius(10)

            Text("Recipe Name")
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
