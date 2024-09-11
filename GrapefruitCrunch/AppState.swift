//
//  AppState.swift
//  GrapefruitCrunch
//
//  Created by Aoi Otani on 2024/09/10.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}
