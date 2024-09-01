//
//  GrapefruitCrunchApp.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//

import SwiftUI

@main
struct GrapefruitCrunchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PastRecipesManager())
        }
    }
}
