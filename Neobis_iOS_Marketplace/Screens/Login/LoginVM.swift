//
//  LoginVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation

// MARK: - DELEGATE PROTOCOL
protocol LoginDelegate: AnyObject {
    func didSucceed(withData data: LoginResponse)
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol LoginProtocol {
    var isLoggedIn: Bool { get }

    var delegate: LoginDelegate? { get set }

    func login(username: String, password: String)
}

// MARK: - VIEW MODEL
class LoginViewModel: LoginProtocol {
    
    var isLoggedIn: Bool = false
    
    weak var delegate: LoginDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }

    func login(username: String, password: String) {
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        apiService.post(endpoint: APIEndpoint.login.rawValue, parameters: parameters, responseType: LoginResponse.self) { result in
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):

                    if let accessToken = data.tokens?.access {
                        TokenManager.shared.accessToken = accessToken
                    }

                    if let refreshToken = data.tokens?.refresh {
                        TokenManager.shared.refreshToken = refreshToken
                    }
                    
                    self.isLoggedIn = true
                    self.delegate?.didSucceed(withData: data)

                case .failure(let error):
                    print("Login fail: \(error)")
                    self.isLoggedIn = false
                    self.delegate?.didFail(withError: error)
                }
            }
        }
    }
    
    
}
