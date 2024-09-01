//
//  HomeView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//



import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    @State private var featuredRecipe: Recipe?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to Recipe Generator")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                Text("What would you like to cook today?")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                if let recipe = featuredRecipe {
                    FeaturedRecipeCard(recipe: recipe)
                } else {
                    ProgressView()
                        .frame(height: 200)
                }
                
                RecentlyViewedSection()
                
                TipsAndTricksSection()
            }
            .padding()
        }
        .onAppear(perform: loadFeaturedRecipe)
    }
    
    private func loadFeaturedRecipe() {
        // Simulate loading a featured recipe
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.featuredRecipe = Recipe(title: "Grilled Lemon Herb Chicken", ingredients: ["Chicken", "Lemon", "Herbs"], instructions: "1. Marinate chicken...\n2. Grill until cooked...")
        }
    }
}

struct FeaturedRecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Recipe")
                .font(.headline)
                .foregroundColor(.purple)
            Text(recipe.title)
                .font(.title2)
                .fontWeight(.bold)
            Text("\(recipe.ingredients.count) ingredients")
                .font(.subheadline)
                .foregroundColor(.gray)
            Button("View Recipe") {
                // Action to view recipe details
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(10)
    }
}

struct RecentlyViewedSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Viewed")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(1...5, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 150, height: 100)
                    }
                }
            }
        }
    }
}

struct TipsAndTricksSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tips & Tricks")
                .font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                TipRow(text: "Use fresh ingredients for better flavor")
                TipRow(text: "Prep ingredients before cooking")
                TipRow(text: "Don't overcrowd the pan")
            }
        }
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "lightbulb")
                .foregroundColor(.yellow)
            Text(text)
                .font(.subheadline)
        }
    }
}
