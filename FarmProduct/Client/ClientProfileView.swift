//
//  ClientProfileView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ClientProfileView: View {
    @State private var user: User? = Auth.auth().currentUser
    @State private var displayName: String = ""
    @State private var updatingProfile = false

    
    var body: some View {
        NavigationView {
            VStack {
                if let user = user {
                    WebImage(url: user.photoURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding(.top, 88)
                    
                    TextField("Display Name", text: $displayName)
                        .padding()
                        .autocapitalization(.none)
                    
                    Text(user.email ?? "")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    Button(action: {
                        updateProfile()
                    }) {
                        Text("Update Profile")
                    }
                    .padding()
                    .disabled(updatingProfile)
                    
                    NavigationLink(destination: ContentView()) {
                        Button(action: {
                            signOut()
                        }) {
                            Text("Sign Out")
                        }
                        .padding()
                    }
                } else {
                    Text("No User Info")
                }
                Spacer()
            }
            .onAppear(perform: getUserInfo)
        }
        
    }
    
    
    func getUserInfo() {
        if let user = Auth.auth().currentUser {
            self.displayName = user.displayName ?? ""
            self.user = user
        }
    }
    
    func updateProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        // changeRequest.photoURL = ... URL to the new photo
        updatingProfile = true
        
        changeRequest.commitChanges { error in
            if let error = error {
                print("Error updating profile: \(error)")
            } else {
                print("Profile updated successfully")
                updatingProfile = false
                getUserInfo()
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            print("Error signing out: \(error)")
        }
    }
    
}

struct ClientProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileView()
    }
}
