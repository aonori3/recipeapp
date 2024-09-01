//
//  ContentView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pastRecipesManager = PastRecipesManager()
    @State private var selectedTab = "Home"

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag("Home")
                
                NewRecipeView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag("NewRecipe")
                
                PastRecipesView()
                    .tabItem {
                        Image(systemName: "bookmark")
                    }
                    .tag("PastRecipes")
            }
            .accentColor(.purple)
        }
        .environmentObject(pastRecipesManager)
    }
}
