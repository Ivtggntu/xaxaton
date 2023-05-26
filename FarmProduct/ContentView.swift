//
//  ContentView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var showAuthenticationView: Bool = false
    @State private var user: User? = Auth.auth().currentUser
    
    var body: some View {
        if user != nil {
            ClientView()
        } else {
            AuthenticationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
