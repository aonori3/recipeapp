import SwiftUI

class ColorSchemeManager: ObservableObject {
    @AppStorage("darkModeEnabled") var darkModeEnabled = false {
        didSet {
            applyColorScheme()
        }
    }
    
    init() {
        applyColorScheme()
    }
    
    func applyColorScheme() {
        setColorScheme(darkModeEnabled ? .dark : .light)
    }
    
    private func setColorScheme(_ colorScheme: ColorScheme) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = colorScheme == .dark ? .dark : .light
            }
        }
    }
}
