//
//  LoginVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation

// MARK: - DELEGATE PROTOCOL
protocol LoginDelegate: AnyObject {
    func loginDidSucceed(withData data: Data)
    func loginDidFail(withError error: Error)
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
        
        apiService.post(
            endpoint: "auth/login/",
            parameters: parameters) { [weak self] (result) in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        
                        print(data.count)
                        
                        let decoder = JSONDecoder()
                        print("success")
                        if let tokenResponse = try? decoder.decode(MarketplaceBase.self, from: data) {
                            
                            print(data.count)

                            TokenManager.shared.accessToken = tokenResponse.tokens?.access
                            print(String(describing: tokenResponse.tokens?.access))
                            
                            TokenManager.shared.refreshToken = tokenResponse.tokens?.refresh
                            print(String(describing: tokenResponse.tokens?.refresh))
                            
//                            TokenManager.shared.saveAccessToken(name: tokenResponse.tokens?.access)
//                            TokenManager.shared.saveRefreshToken(name: tokenResponse.tokens?.refresh)

//                            TokenManager.shared.accessToken = tokenResponse.tokens.access
//                            TokenManager.shared.refreshToken = tokenResponse.tokens.refresh

//                            print(UserDefaults.standard.string(forKey: "AccessToken") ?? "")
//                            print(UserDefaults.standard.string(forKey: "RefreshToken") ?? "")
                                                        
                            
                            self?.isLoggedIn = true
                            self?.delegate?.loginDidSucceed(withData: data)
                        }
                    case .failure(let error):
                        print("fail")
                        self?.isLoggedIn = false
                        self?.delegate?.loginDidFail(withError: error)
                    }
                }
            }
    }

    
    
}
