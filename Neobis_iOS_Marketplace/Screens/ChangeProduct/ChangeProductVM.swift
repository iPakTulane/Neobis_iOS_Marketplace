//
//  ChangeProductVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//


import Foundation
import UIKit

// MARK: - PROTOCOL
protocol ChangeProductViewModelProtocol: AnyObject {
    var isChanged: Bool { get }
    var changeResult: ((Result<ProductResponse, Error>) -> Void)? { get set }
    
    func changeProduct(images: [UIImage], title: String, price: String, short_description: String?, description: String?)
}

// MARK: - VIEW MODEL
class ChangeProductViewModel: ChangeProductViewModelProtocol {
    
    var isChanged: Bool = false
    var changeResult: ((Result<ProductResponse, Error>) -> Void)?
    
    let apiService: APIService
    private let id: Int
    
    init(id: Int) {
        self.apiService = APIService()
        self.id = id
    }
    
    func changeProduct(images: [UIImage], title: String, price: String, short_description: String?, description: String?) {
        let imageDatas = images.compactMap { $0.jpegData(compressionQuality: 1.0) }
        
        let endpoint = "product/\(id)/"
        
        let parameters: [String: Any] = [
            "title": title,
            "price": price,
            "short_description": short_description ?? "",
            "description": description ?? ""
        ]
        
        apiService.putImagesWithBearerToken(endpoint: endpoint, parameters: parameters, imageDatas: imageDatas, bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productResponse):
                    // Handle the ProductResponse object
                    print("Product changed with ID: \(productResponse.id ?? 0)")
                    self?.isChanged = true
                    self?.changeResult?(.success(productResponse))
                case .failure(let error):
                    let errorMessage = "Failed to change product: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isChanged = false
                    self?.changeResult?(.failure(error))
                }
            }
        }
    }
}

