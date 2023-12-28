//
//  ProductVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import Alamofire

// MARK: - PROTOCOL
protocol ProductProtocol {
    func fetchProductData(completion: @escaping (Result<[[String: Any]], Error>) -> Void)
    
    var isDeleted: Bool { get }
    var deleteResult: ((Result<Data, Error>) -> Void)? { get set }
    func deleteProduct(withID: Int)
}

// MARK: - VIEW MODEL
class ProductViewModel: ProductProtocol {
    
    var isDeleted: Bool = false
    var deleteResult: ((Result<Data, Error>) -> Void)?
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchProductData(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let accessToken = TokenManager.shared.accessToken else {
            let error = NSError(domain: "AuthorizationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
            completion(.failure(error))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        apiService.getProductData(headers: headers) { result in
            switch result {
            case .success(let dataArray):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8)
//                    print(jsonString ?? "")
                    completion(.success(dataArray))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProduct(withID id: Int) {
        apiService.deleteData(id: id, bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isDeleted = true
                    self?.deleteResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed to delete product: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isDeleted = false
                    self?.deleteResult?(.failure(error))
                }
            }
        }
    }
}
