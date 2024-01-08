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
    
    func addProduct(images: [UIImage], title: String, price: String, shortDescription: String?, fullDescription: String?)
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
        images: [UIImage],
        title: String,
        price: String,
        shortDescription: String?,
        fullDescription: String?) {
            
            let imageDatas = images.compactMap { $0.jpegData(compressionQuality: 1.0) }
            
            let endpoint = "products/create-update-list/"
            
            let parameters: [String: Any] = [
                "title": title,
                "price": price,
                "short_description": shortDescription ?? "",
                "full_description": fullDescription ?? ""
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
