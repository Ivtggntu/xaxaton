//
//  ClientBasketView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI
import FirebaseFirestore

struct ClientBasketView: View {
    
    @State private var basket = [Product]()
    
    // Предполагается userId из системы аутентификации
    @State private var userId: String = "lQsAZ5FfW3PKVnaXNOoen4ypOIb2"
    
    var body: some View {
        NavigationView {
            List(basket) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text(String(format: "%.2f$", product.price))
                        .font(.subheadline)
                }
            }
            .onAppear(perform: loadData)
        .navigationTitle("Basket")
        }
    }
        
    func loadData() {
        let db = Firestore.firestore()
        
        db.collection("baskets").document(userId).addSnapshotListener { (document, error) in
            if let error = error {
                print("Error loading cart: \(error)")
            } else {
                if let document = document, document.exists {
                    let data = document.data()
                    let cartProducts = data?["products"] as? [[String: Any]] ?? []
                    
                    self.basket = cartProducts.compactMap { productData -> Product? in
                        let id = productData["id"] as? String ?? ""
                        let name = productData["name"] as? String ?? ""
                        let price = productData["price"] as? Double ?? 0.0
                        
                        return Product(id: id, name: name, price: price)
                    }
                }
            }
        }
    }

}

struct ClientBasketView_Previews: PreviewProvider {
    static var previews: some View {
        ClientBasketView()
    }
}
