//
//  ProfileView.swift
//  GrapefruitCrunch
//
//  Created by Aoi Otani on 2024/08/30.
//

import Foundation

struct ProfileView: View {
    @Binding var currentView: String
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.pink)
                .padding()
            
            Text("User Profile")
                .font(.title)
                .padding()
            
            Text("Name: John Doe")
            Text("Email: john@example.com")
            
            Spacer()
            NavigationBarView(currentView: $currentView)
        }
    }
}
