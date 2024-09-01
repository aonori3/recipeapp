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
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(selectedTab: $selectedTab)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            // Add menu action here
                        }) {
                            Image(systemName: "line.horizontal.3")
                        }
                    )
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            .tag("Home")
            
            NavigationView {
                NewRecipeView()
                    .navigationBarTitle("New Recipe")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            .tag("NewRecipe")
            
            NavigationView {
                PastRecipesView()
                    .navigationBarTitle("Saved Recipes")
            }
            .tabItem {
                Image(systemName: "bookmark")
            }
            .tag("PastRecipes")
            
            Text("Profile Placeholder")
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag("Profile")
        }
        .accentColor(.purple)
        .environmentObject(pastRecipesManager)
    }
}
