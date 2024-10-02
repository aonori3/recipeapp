import SwiftUI
import Firebase
import FirebaseAuth

@main
struct GrapefruitCrunchApp: App {
    @State private var userIsLoggedIn = false
    @StateObject private var colorSchemeManager = ColorSchemeManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if userIsLoggedIn {
                    ContentView(userIsLoggedIn: $userIsLoggedIn)
                        .environmentObject(PastRecipesManager())
                } else {
                    LoginView(userIsLoggedIn: $userIsLoggedIn)
                        .onAppear {
                            checkUserAuthStatus()
                        }
                }
            }
            .environmentObject(colorSchemeManager)
            .preferredColorScheme(colorSchemeManager.darkModeEnabled ? .dark : .light)
        }
    }

    func checkUserAuthStatus() {
        if Auth.auth().currentUser != nil {
            userIsLoggedIn = true
        }
    }
}
