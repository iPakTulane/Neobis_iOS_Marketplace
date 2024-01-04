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
    func registrationDidSucceed(withData data: Data)
    func registrationDidFail(withError error: Error)
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
            endpoint: "auth/register/",
            parameters: parameters) { [weak self] (result) in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let dataString = String(data: data, encoding: .utf8)
                        print("Data received: \(dataString ?? "nil")")
                        self?.isRegistered = true
                        self?.delegate?.registrationDidSucceed(withData: data)
                    case .failure(let error):
                        let errorMessage = "Failed register number: \(error.localizedDescription)"
                        print(errorMessage)
                        self?.isRegistered = false
                        self?.delegate?.registrationDidFail(withError: error)
                    }
                }
            }
    }
    
}
