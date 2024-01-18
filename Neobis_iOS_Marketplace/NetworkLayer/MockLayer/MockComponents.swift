//
//  MockComponents.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 16/01/24.
//

import Foundation

struct MockUser : Codable {
    let avatar : String
    let username : String
    let email : String
    let first_name : String
    let last_name : String
    let date_of_birth : String
    let phone_number : String
}

struct MockProduct : Codable {
    let id : Int
    let name : String
    let description : String
    let short_description : String
    let available : Bool
    let price : String
    let photos : [MockPhoto]
}

struct MockPhoto : Codable {
    let id : Int
    let photo : String
}


let mockProducts: [MockProduct] = [
    MockProduct(id: 1,
                name: "Product 1",
                description: "Full description 1",
                short_description: "Short description 1",
                available: true,
                price: "1",
                photos: [
                    MockPhoto(id: 1, photo: "mockPic1"),
                    MockPhoto(id: 2, photo: "mockPic2")
                ]),
    MockProduct(id: 2,
                name: "Product 2",
                description: "Full description 2",
                short_description: "Short description 2",
                available: true,
                price: "2",
                photos: [
                    MockPhoto(id: 1, photo: "mockPic3"),
                    MockPhoto(id: 2, photo: "mockPic4")
                ]),
]

let mockPhotos: [MockPhoto] = [
    MockPhoto(id: 1,
               photo: "mockPic1"),
    MockPhoto(id: 2,
               photo: "mockPic2"),
    MockPhoto(id: 3,
               photo: "mockPic3"),
    MockPhoto(id: 4,
               photo: "mockPic4"),
]



class MockAPIService {
    
    func fetchProducts(completion: @escaping ([MockProduct]) -> Void) {
        completion(mockProducts)
    }
}


// MARK: - USAGE
//let apiService = MockAPIService()
//apiService.fetchProducts { products in
//    for product in products {
//        print("ID: \(product.id), Name: \(product.name), Price: \(product.price)")
//    }
//}
