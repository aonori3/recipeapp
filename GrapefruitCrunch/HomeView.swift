//
//  HomeView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//



import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 30) {
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
            .padding(.top, 20)
            
            Spacer()
            
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.purple)
                .padding(.bottom, 10)
            
            Text("Home")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            VStack {
                NavigationLink(destination: NewRecipeView()) {
                    Text("Find a new recipe")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
                .padding()
                
                NavigationLink(destination: PastRecipesView()) {
                    Text("Saved recipes")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}
