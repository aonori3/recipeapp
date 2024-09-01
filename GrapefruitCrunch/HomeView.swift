//
//  HomeView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//



import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Recipe Generator")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Button(action: {
                selectedTab = "NewRecipe"
            }) {
                Text("Find a new recipe")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
            
            Button(action: {
                selectedTab = "PastRecipes"
            }) {
                Text("Saved recipes")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
    }
}
