//
//  ProfileView.swift
//  GrapefruitCrunch
//
//  Created by Aoi Otani on 2024/09/10.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @State private var username = "Your Name"
    @State private var email = "Your Email"
    @State private var darkModeEnabled = false
    @State private var selectedDietaryPreference = "None"
    @State private var showingLogoutAlert = false
    @State private var showingChangePasswordView = false
    @Binding var userIsLoggedIn: Bool
    
    let dietaryPreferences = ["None", "Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Profile")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    VStack(alignment: .center) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.primaryColor)
                        
                        TextField("Username", text: $username)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text(email)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Preferences")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Picker("Dietary Preference", selection: $selectedDietaryPreference) {
                            ForEach(dietaryPreferences, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        
                        Toggle("Dark Mode", isOn: $darkModeEnabled)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            showingChangePasswordView = true
                        }) {
                            Text("Change Password")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryColor)
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            showingLogoutAlert = true
                        }) {
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryColor)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .accentColor(.primaryColor)
        .onAppear {
            loadUserData()
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Log Out"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Log Out")) {
                    signOut()
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showingChangePasswordView) {
            ChangePasswordView()
        }
    }
    
    private func loadUserData() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? ""
            // Load other user data
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            userIsLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct ChangePasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccessAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Change Your Password")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    Text("Enter and confirm your new password")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    
                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Confirm New Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    Button(action: {
                        changePassword()
                    }) {
                        Text("Change Password")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor)
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(isSuccessAlert ? "Success" : "Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccessAlert {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }

    func changePassword() {
        if newPassword != confirmPassword {
            alertMessage = "Passwords do not match"
            isSuccessAlert = false
            showAlert = true
            return
        }

        if let user = Auth.auth().currentUser {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    alertMessage = error.localizedDescription
                    isSuccessAlert = false
                } else {
                    alertMessage = "Password successfully changed!"
                    isSuccessAlert = true
                }
                showAlert = true
            }
        }
    }
}
