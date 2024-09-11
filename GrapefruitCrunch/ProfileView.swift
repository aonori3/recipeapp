//
//  ProfileView.swift
//  GrapefruitCrunch
//
//  Created by Aoi Otani on 2024/09/10.
//

import SwiftUI

struct ProfileView: View {
    @State private var username = "John Doe"
    @State private var email = "@gmail.com"
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var selectedDietaryPreference = "None"
    
    let dietaryPreferences = ["None", "Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.primaryColor)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }
                
                Section(header: Text("Preferences")) {
                    Picker("Dietary Preference", selection: $selectedDietaryPreference) {
                        ForEach(dietaryPreferences, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }
                
                Section(header: Text("Account")) {
                    Button(action: {
                        // Implement change password functionality
                    }) {
                        Text("Change Password")
                    }
                    
                    Button(action: {
                        // Implement logout functionality
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }
        .accentColor(.primaryColor)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
