//
//  NavigationBarView.swift
//  GrapefruitCrunch
//
//  Created by Aoi Otani on 2024/08/30.
//

import SwiftUI


struct NavigationBarView: View {
    @Binding var currentView: String
    
    var body: some View {
        HStack {
            Button(action: { currentView = "Home" }) {
                Image(systemName: "house.fill")
                    .foregroundColor(currentView == "Home" ? .purple : .gray)
            }
            Spacer()
            Button(action: { currentView = "NewRecipe" }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(currentView == "NewRecipe" ? .purple : .gray)
            }
            Spacer()
            Button(action: { currentView = "PastRecipes" }) {
                Image(systemName: "bookmark")
                    .foregroundColor(currentView == "PastRecipes" ? .purple : .gray)
            }
            Spacer()
            Image(systemName: "person.circle")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
