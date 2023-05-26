//
//  ClientView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI

struct ClientView: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case .home:
                ClientHomeView()
            case .catalog:
                ClientCatalogView()
            case .basket:
                ClientBasketView()
            case .profile:
                ClientProfileView()
            }
            
            ClientTabBarView(selectedTab: $selectedTab)
        }
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView()
    }
}
