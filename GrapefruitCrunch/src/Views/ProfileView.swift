import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

struct ProfileView: View {
    @State private var username = "Your Name"
    @State private var email = "Your Email"
    @State private var selectedDietaryPreference = "None"
    @State private var showingLogoutAlert = false
    @State private var showingChangePasswordView = false
    @Binding var userIsLoggedIn: Bool
    
    @State private var profileImage: UIImage?
    @State private var showingImagePicker = false
    
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    @Environment(\.colorScheme) var colorScheme
    
    let dietaryPreferences = ["None", "Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Profile")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.top, 20)
                    
                    VStack(alignment: .center) {
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.primary)
                            }
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: uploadProfilePicture) {
                            ImagePicker(image: $profileImage)
                        }
                        
                        TextField("Username", text: $username)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Text(email)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
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
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        
                        Toggle("Dark Mode", isOn: $colorSchemeManager.darkModeEnabled)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
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
                                .background(Color.accentColor)
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
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .accentColor(.accentColor)
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
            loadProfilePicture()
        }
    }
    
    private func loadProfilePicture() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_pictures/\(uid).jpg")
        
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading profile picture: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage = image
                }
            }
        }
    }
    
    private func uploadProfilePicture() {
        guard let uid = Auth.auth().currentUser?.uid, let image = profileImage else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not convert image to data")
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_pictures/\(uid).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading profile picture: \(error.localizedDescription)")
            } else {
                print("Profile picture uploaded successfully")
            }
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

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
