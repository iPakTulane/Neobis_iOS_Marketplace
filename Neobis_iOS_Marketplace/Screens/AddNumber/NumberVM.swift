//
//  NumberVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//


import Foundation
import Alamofire


// MARK: - DELEGATE PROTOCOL
protocol NumberDelegate: AnyObject {
    func didSucceed(withData data: Data)
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol NumberProtocol {
    var isFullyRegistered: Bool { get }
    var delegate: NumberDelegate? { get set }
    
    func fullRegister(phone_number: String)
}

// MARK: - VIEW MODEL
class NumberViewModel: NumberProtocol {
    
    var isFullyRegistered: Bool = false
    
    weak var delegate: NumberDelegate?
    
    let apiService: APIService
    
    private let first_name: String
    private let last_name: String
    private let date_of_birth: String
    private let avatar: Data
    
    init(first_name: String, last_name: String, date_of_birth: String, avatar: Data) {
        self.apiService = APIService()
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.avatar = avatar
    }
    
    func fullRegister(phone_number: String) {
        
        let parameters: [String: Any] = [
            "first_name": first_name,
            "last_name": last_name,
            "date_of_birth": date_of_birth,
            "phone_number": phone_number,
            "avatar": avatar
        ]
        
        apiService.postWithBearerToken(
            endpoint: APIEndpoint.fullRegister.rawValue,
            parameters: parameters,
            bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.isFullyRegistered = true
                        self?.delegate?.didSucceed(withData: data)
                    case .failure(let error):
                        self?.isFullyRegistered = false
                        self?.delegate?.didFail(withError: error)
                    }
                }
            }
    }
    
}
