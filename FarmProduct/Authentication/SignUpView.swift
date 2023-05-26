//
//  SignInView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty, password == repeatPassword else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let returnUserData = try await Authentication().createUser(email: email, password: password)
                print("Sign Up: \(returnUserData)")
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.32))
                .cornerRadius(16)
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.32))
                .cornerRadius(16)
            SecureField("Repeat password...", text: $viewModel.repeatPassword)
                .padding()
                .background(Color.gray.opacity(0.32))
                .cornerRadius(16)
            
            Button {
                viewModel.signUp()
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
        .navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}
