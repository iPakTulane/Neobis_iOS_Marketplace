//
//  ProfileVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation


// MARK: - DELEGATE PROTOCOL
protocol ProfileDelegate: AnyObject {
    func profileDidSucceed(withData data: UpdateUserResponse)
    func profileDidFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol ProfileProtocol {
    var isActive: Bool { get }
    var delegate: ProfileDelegate? { get set }

//    func activate(code: String)
}

// MARK: - VIEW MODEL
class ProfileViewModel: ProfileProtocol {
    
    var isActive: Bool = false
    weak var delegate: ProfileDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }

//    func activate(code: String) {
//
//        let parameters: [String: Any] = [
//            "code": code
//        ]
//
//        apiService.post(endpoint: APIEndpoint.otp.rawValue, parameters: parameters, responseType: OTPResponse.self) { result in
//
//            DispatchQueue.main.async {
//                switch result {
//
//                case .success(let data):
//                    print(data)
//                    self.isVerified = true
//                    self.delegate?.otpDidSucceed(withData: data)
//
//                case .failure(let error):
//                    print("OTP fail: \(error)")
//                    self.isVerified = false
//                    self.delegate?.otpDidFail(withError: error)
//                }
//            }
//        }
//    }
    
}

