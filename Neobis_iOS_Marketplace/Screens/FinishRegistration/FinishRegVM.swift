//
//  FinishRegVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation
import Alamofire


// MARK: - DELEGATE PROTOCOL
protocol FinishRegDelegate: AnyObject {
    func didSucceed(withData data: [UpdateUserResponse])
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol FinishRegProtocol {
    var isFullyRegistered: Bool { get }
    var delegate: FinishRegDelegate? { get set }
    
    func updateUserData(completion: @escaping (Result<UpdateUserResponse, Error>) -> Void)
}

// MARK: - VIEW MODEL
class FinishRegViewModel: FinishRegProtocol {
    
    var delegate: FinishRegDelegate?
    
    func updateUserData(completion: @escaping (Result<UpdateUserResponse, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = apiService.baseURL + APIEndpoint.updateUserData.rawValue
        
        apiService.getUserData(
            url: url,
            headers: headers,
            responseType: [UpdateUserResponse].self) { result in
                switch result {
                    
                case .success(let data):
                    print("Finish registration success: \(data)")
                    self.isFullyRegistered = true
                    self.delegate?.didSucceed(withData: data)
                
                case .failure(let error):
                    print("Finish registration fail: \(error.localizedDescription)")
                    self.isFullyRegistered = false
                    self.delegate?.didFail(withError: error)
                }
            }
    }

    var isFullyRegistered: Bool = false
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
}

