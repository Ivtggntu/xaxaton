//
//  AuthenticationView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

final class Authentication {
    
    func currentUser() throws -> AuthDataResultModel {
        guard let userData = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: userData)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authData.user)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authData = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authData.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

struct AuthenticationView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                
            }
            .padding()
            .navigationTitle("Authentication")
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
