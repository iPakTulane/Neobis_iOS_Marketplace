//
//  ProfileVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation
import Alamofire


// MARK: - DELEGATE PROTOCOL
protocol ProfileDelegate: AnyObject {
    func didSucceed(withData data: GetUserResponse)
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol ProfileProtocol {
    var isRegistered: Bool { get }
    var isFullyRegistered: Bool { get }
    var delegate: ProfileDelegate? { get set }
    
    func getUserData(completion: @escaping (Result<GetUserResponse, Error>) -> Void)
    
    func updateUserData(completion: @escaping (Result<UpdateUserResponse, Error>) -> Void)
}

// MARK: - VIEW MODEL
class ProfileViewModel: ProfileProtocol {
    
    func getUserData(completion: @escaping (Result<GetUserResponse, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = apiService.baseURL + APIEndpoint.getUserData.rawValue
        
        apiService.getUserData(
            url: url,
            headers: headers,
            responseType: GetUserResponse.self) { result in
                switch result {
                    
                case .success(let data):
                    print("Profile success: \(data)")
                    self.isRegistered = true
                    self.delegate?.didSucceed(withData: data)
                
                case .failure(let error):
                    print("Profile fail: \(error.localizedDescription)")
                    self.isRegistered = false
                    self.delegate?.didFail(withError: error)
                }
            }
        
        
    }

    var isRegistered: Bool = true
    var isFullyRegistered: Bool = false

    weak var delegate: ProfileDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    
    func updateUserData(completion: @escaping (Result<UpdateUserResponse, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let url = apiService.baseURL + APIEndpoint.updateUserData.rawValue
        
        apiService.getUserData(
            url: url,
            headers: headers,
            responseType: UpdateUserResponse.self) { result in
                switch result {
                    
                case .success(let data):
                    print("Finish registration success: \(data)")
                    self.isFullyRegistered = true
//                    self.delegate?.didSucceed(withData: data)
                
                case .failure(let error):
                    print("Finish registration fail: \(error.localizedDescription)")
                    self.isFullyRegistered = false
                    self.delegate?.didFail(withError: error)
                }
            }
    }
    
}

