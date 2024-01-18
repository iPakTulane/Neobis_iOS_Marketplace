//
//  ProductVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import Alamofire
import AlamofireImage

// MARK: - DELEGATE PROTOCOL
protocol ProductDelegate: AnyObject {
    func didSucceed()
    func didFail(withError error: Error)
}
///////////////////////////////////////////////////////////////////////////////////

// MARK: - PROTOCOL
protocol ProductProtocol {
    
    var isEmpty: Bool { get set }
    var products: [ProductResponse]? { get set }
    var delegate: ProductDelegate? { get set }
    
    func fetchData()
    func deleteData(withID id: Int)
}

///////////////////////////////////////////////////////////////////////////////////

// MARK: - VIEW MODEL
class ProductViewModel: ProductProtocol {
    
    var isEmpty: Bool = true
    var products: [ProductResponse]? = []
    weak var delegate: ProductDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////
    
    func fetchData() {
        
        guard let url = URL(string: apiService.baseURL + APIEndpoint.product.rawValue) else { return }
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        guard let url = URL(string: apiService.baseURL + APIEndpoint.product.rawValue) else { return }
        
        let method = HTTPMethod.get
        
        
        apiService.getProductData(url: url,
                                  method: method,
                                  parameters: nil,
                                  headers: headers,
                                  responseType: [ProductResponse].self) { result in
            switch result {
                
            case .success(let data):
                print("Home success: \(data)")
                self.products = data
                self.isEmpty = false
                self.delegate?.didSucceed()
                
            case .failure(let error):
                print("Home fail: \(error.localizedDescription)")
                self.isEmpty = true
                self.delegate?.didFail(withError: error)
            }
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////
    
    func deleteData(withID id: Int) {
        apiService.deleteData(
            id: id,
            bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("Delete success")
                        self?.delegate?.didSucceed()
                    case .failure(let error):
                        print("Delete fail: \(error.localizedDescription)")
                        self?.delegate?.didFail(withError: error)
                    }
                }
            }
    }
}
