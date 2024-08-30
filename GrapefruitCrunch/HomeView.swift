//
//  HomeView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.pink)

            Text("Home")
                .font(.largeTitle)
                .padding(.top, 20)

            Spacer()

            VStack {
                NavigationLink(destination: NewRecipeView()) {
                    Text("Find a new recipe")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: PastRecipesView()) {
                    Text("Past recipes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
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
            .foregroundColor(.pink)
        }
    }
}
