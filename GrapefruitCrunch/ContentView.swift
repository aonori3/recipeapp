//
//  ContentView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pastRecipesManager = PastRecipesManager()
    @State private var currentView = "Home"

    var body: some View {
        NavigationView {
            VStack {
                switch currentView {
                case "Home":
                    HomeView()
                case "NewRecipe":
                    NewRecipeView()
                case "PastRecipes":
                    PastRecipesView()
                default:
                    HomeView()
                }
                
                NavigationBarView(currentView: $currentView)
            }
            .environmentObject(pastRecipesManager)
            .navigationBarHidden(true)
        }
    }
}
