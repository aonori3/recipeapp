//
//  ContentView.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject var pastRecipesManager = PastRecipesManager()

    var body: some View {
        NavigationView {
            HomeView()
                .environmentObject(pastRecipesManager)
                .navigationBarHidden(true)
        }
    }
}
