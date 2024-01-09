//
//  AddProductVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
    
// MARK: - PROTOCOL
protocol AddProductViewModelProtocol: AnyObject {
    var isAdded: Bool { get }
    var addResult: ((Result<ProductResponse, Error>) -> Void)? { get set }
    
    func addProduct(
        name: String,
        available: Bool,
        price: String,
        short_description: String?,
        description: String?,
        images: [UIImage])
}

// MARK: - VIEW MODEL
class AddProductViewModel: AddProductViewModelProtocol {
    
    var isAdded: Bool = false
    var addResult: ((Result<ProductResponse, Error>) -> Void)?
    
    let apiService: APIService
    
    // MARK: - INIT
    init() {
        self.apiService = APIService()
    }

    func addProduct(
        name: String,
        available: Bool,
        price: String,
        short_description: String?,
        description: String?,
        images: [UIImage]) {
            
            let imageDatas = images.compactMap { $0.jpegData(compressionQuality: 0.1) }
            
            let endpoint = APIEndpoint.product.rawValue
            
            let parameters: [String: Any] = [
                "name": name,
                "available" : true,
                "price": price,
                "short_description" : short_description,
                "description" : description
            ]

            apiService.postImagesWithBearerToken(
                endpoint: endpoint,
                parameters: parameters, 
                imageDatas: imageDatas,
                bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let productResponse):
                        // Call the addResult closure with the ProductResponse object
                        self?.addResult?(.success(productResponse))
                        
                        // Additional handling specific to ProductResponse if needed
                        print("Product added with ID: \(productResponse.id ?? 0)")
                        self?.isAdded = true
                        
                    case .failure(let error):
                        // Call the addResult closure with the failure
                        self?.addResult?(.failure(error))
                        
                        let errorMessage = "Failed to add product: \(error.localizedDescription)"
                        print(errorMessage)
                        self?.isAdded = false
                    }
                }
            }
    }
}
