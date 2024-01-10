//
//  PasswordVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit

// MARK: - DELEGATE
protocol PasswordDelegate: AnyObject {
    func didSucceed(withData data: RegisterResponse)
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol PasswordProtocol {
    var isRegistered: Bool { get }
    
    var delegate: PasswordDelegate? { get set }
    
    func register(password: String, password_confirm: String)
}

// MARK: - VIEW MODEL
class PasswordViewModel: PasswordProtocol {
    
    var isRegistered: Bool = false
    
    weak var delegate: PasswordDelegate?
    
    let apiService: APIService
    
    private let userName: String
    private let email: String
    
    init(userName: String, email: String) {
        self.apiService = APIService()
        self.userName = userName
        self.email = email
    }
    
    
    func register(password: String, password_confirm: String) {
        let parameters: [String: Any] = [
            "username": userName,
            "email": email,
            "password": password,
            "password_confirm": password_confirm
        ]
        
        apiService.post(
            endpoint: APIEndpoint.register.rawValue,
            parameters: parameters,
            responseType: RegisterResponse.self) { [weak self] (result) in
                
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let data):
                        print("Data received: \(data)")
                        
                        self?.isRegistered = true
                        self?.delegate?.didSucceed(withData: data)
                        
                    case .failure(let error):
                        let errorMessage = "Failed register number: \(error.localizedDescription)"
                        print(errorMessage)
                        
                        self?.isRegistered = false
                        self?.delegate?.didFail(withError: error)
                    }
                }
            }
    }
}








