//
//  ClientTabBarView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI

enum Tab: String {
    case home
    case catalog
    case basket
    case profile
}

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var tab: Tab
}

var TabItems = [
    TabItem(icon: "house", tab: .home),
    TabItem(icon: "square.on.square", tab: .catalog),
    TabItem(icon: "cart", tab: .basket),
    TabItem(icon: "person.crop.circle", tab: .profile)
]

struct ClientTabBarView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                ForEach(TabItems) { item in
                    Button {
                        selectedTab = item.tab
                    } label: {
                        Image(systemName: item.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.primary)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: Color.green, radius: 16, x: 0, y: 16)
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct ClientTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ClientTabBarView(selectedTab: .constant(.home))
    }
}
