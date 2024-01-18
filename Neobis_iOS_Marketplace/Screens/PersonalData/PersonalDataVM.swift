//
//  PersonalDataVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation
import Alamofire


// MARK: - DELEGATE PROTOCOL
protocol PersonalDataDelegate: AnyObject {
    func didSucceed(withData data: [UpdateUserResponse])
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol PersonalDataProtocol {
    var isActive: Bool { get }
    var delegate: PersonalDataDelegate? { get set }
    
    func updateUserData(completion: @escaping (Result<UpdateUserResponse, Error>) -> Void)
}

// MARK: - VIEW MODEL
class PersonalDataViewModel: PersonalDataProtocol {
    
    var delegate: PersonalDataDelegate?
    
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
                    print("Personal Data success: \(data)")
                    self.isActive = false
                    self.delegate?.didSucceed(withData: data)
                
                case .failure(let error):
                    print("Personal Data fail: \(error.localizedDescription)")
                    self.isActive = true
                    self.delegate?.didFail(withError: error)
                }
            }
    }

    var isActive: Bool = false
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
}

