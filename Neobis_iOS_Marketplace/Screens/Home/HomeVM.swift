//
//  HomeVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//


import Foundation
import Alamofire

// MARK: - DELEGATE PROTOCOL
protocol HomeDelegate: AnyObject {
    func didSucceed(withData data: [ProductResponse])
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol HomeProtocol {
    var isEmpty: Bool { get }
    var products: [ProductResponse]? {get set}
    var delegate: HomeDelegate? { get set }
    
    func fetchProductData(completion: @escaping (Result<[ProductResponse], Error>) -> Void)
    
    func getData()
}

// MARK: - VIEW MODEL
class HomeViewModel: HomeProtocol {
    
    func fetchProductData(completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        apiService.getProductData(
            headers: headers,
            responseType: [ProductResponse].self) { result in
                switch result {
                    
                case .success(let data):
                    print("Home success: \(data)")
                    self.isEmpty = false
                    self.delegate?.didSucceed(withData: data)
                
                case .failure(let error):
                    print("Home fail: \(error)")
                    self.isEmpty = true
                    self.delegate?.didFail(withError: error)
                }
            }
    }
    
    
    var isEmpty: Bool = true
    
    var products: [ProductResponse]? = []
    weak var delegate: HomeDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func getData() {
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        if accessToken != "" {
            
            apiService.getProductData(
                headers: headers,
                responseType: [ProductResponse].self) { result in
                    switch result {
                        
                    case .success(let data):
                        print("Home success: \(data)")
                        self.isEmpty = false
                        self.products = data
                        self.delegate?.didSucceed(withData: data)
                        
                    case .failure(let error):
                        print("Home fail: \(error)")
                        self.isEmpty = true
                        self.delegate?.didFail(withError: error)
                    }
                }
        }
    }
}
