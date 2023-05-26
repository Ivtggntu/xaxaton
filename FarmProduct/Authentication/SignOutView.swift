//
//  SignOutView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI

@MainActor
final class SignOutViewModel: ObservableObject {
    
    func signOut() throws {
        try Authentication().signOut()
    }
}

struct SignOutView: View {
    
    @StateObject private var viewModel = SignOutViewModel()
    @Binding var showAuthenticationView: Bool
    
    var body: some View {
        List {
            Button("Sign Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showAuthenticationView = true
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView(showAuthenticationView: .constant(false))
    }
}
