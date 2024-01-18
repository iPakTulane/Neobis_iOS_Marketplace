//
//  HomeVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation
import Alamofire
import AlamofireImage

// MARK: - DELEGATE PROTOCOL
protocol HomeDelegate: AnyObject {
    func didSucceed(withData data: [ProductResponse])
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol HomeProtocol {
    var isEmpty: Bool { get set }
    var products: [ProductResponse]? { get set }
    var delegate: HomeDelegate? { get set }
    
    func fetchData()
}

// MARK: - VIEW MODEL
class HomeViewModel: HomeProtocol {
    
    var isEmpty: Bool = true
    var products: [ProductResponse]? = []
    weak var delegate: HomeDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
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
                self.delegate?.didSucceed(withData: data)
                
            case .failure(let error):
                print("Home fail: \(error.localizedDescription)")
                self.isEmpty = true
                self.delegate?.didFail(withError: error)
            }
        }
    }
}
