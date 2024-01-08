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
    func registrationDidSucceed(withData data: Data)
    func registrationDidFail(withError error: Error)
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
    private let birthday: String
    private let photo: Data
    
    init(first_name: String, last_name: String, birthday: String, photo: Data) {
        self.apiService = APIService()
        self.first_name = first_name
        self.last_name = last_name
        self.birthday = birthday
        self.photo = photo
    }
    
    func fullRegister(phone_number: String) {
        
        let parameters: [String: Any] = [
            "first_name": first_name,
            "last_name": last_name,
            "birthday": birthday,
            "phone_number": phone_number,
            "photo": photo
        ]
        
        apiService.postWithBearerToken(
            endpoint: APIEndpoint.fullRegister.rawValue,
            parameters: parameters,
            bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.isFullyRegistered = true
                        self?.delegate?.registrationDidSucceed(withData: data)
                    case .failure(let error):
                        self?.isFullyRegistered = false
                        self?.delegate?.registrationDidFail(withError: error)
                    }
                }
            }
    }
    
}
