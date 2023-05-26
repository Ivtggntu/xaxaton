//
//  ClientCatalogView.swift
//  FarmProduct
//
//  Created by Зильбухар on 26.05.2023.
//

import SwiftUI
import FirebaseFirestore

struct Product: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var price: Double
}

struct ClientCatalogView: View {
    @State private var products = [Product]()
    
    // Предполагается userId из системы аутентификации
    @State private var userId: String = "lQsAZ5FfW3PKVnaXNOoen4ypOIb2"
    
    var body: some View {
        NavigationView {
            List(products) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text(String(format: "%.2f$", product.price))
                        .font(.subheadline)
                    
                    Button(action: {
                        addProductToCart(product: product)
                    }) {
                        Text("Add to cart")
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("Products")
        }
    }
    
    func loadData() {
        let db = Firestore.firestore()
        
        db.collection("products").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    self.products = querySnapshot.documents.compactMap { document -> Product? in
                        let data = document.data()
                        let id = document.documentID
                        let name = data["name"] as? String ?? ""
                        let price = data["price"] as? Double ?? 0.0
                        
                        return Product(id: id, name: name, price: price)
                    }
                }
            }
        }
    }
    
    func addProductToCart(product: Product) {
        let db = Firestore.firestore()
        
        db.collection("baskets").document(userId).updateData([
            "products": FieldValue.arrayUnion([["id": product.id, "name": product.name, "price": product.price] as [String : Any]])
        ]) { error in
            if let error = error {
                print("Error adding product to cart: \(error)")
            } else {
                print("Product successfully added to cart")
            }
        }
    }
}


struct ClientCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCatalogView()
    }
}
