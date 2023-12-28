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
    var changeResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func changeProduct(images: [UIImage], title: String, price: String, shortDescription: String?, fullDescription: String?)
}

// MARK: - VIEW MODEL
class ChangeProductViewModel: ChangeProductViewModelProtocol {
    
    var isChanged: Bool = false
    var changeResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    private let id: Int
    
    init(id: Int) {
        self.apiService = APIService()
        self.id = id
    }
    
    func changeProduct(images: [UIImage], title: String, price: String, shortDescription: String?, fullDescription: String?) {
        let imageDatas = images.compactMap { $0.jpegData(compressionQuality: 1.0) }
        
        let endpoint = "product/\(id)/"
        
        let parameters: [String: Any] = [
            "title": title,
            "price": price,
            "short_description": shortDescription ?? "",
            "full_description": fullDescription ?? ""
        ]
        
        apiService.putImagesWithBearerToken(endpoint: endpoint, parameters: parameters, imageDatas: imageDatas, bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isChanged = true
                    self?.changeResult?(.success(data))
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
