//
//  FinishRegVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation


// MARK: - DELEGATE PROTOCOL
protocol FinishRegDelegate: AnyObject {
    func didSucceed(withData data: UpdateUserResponse)
    func didFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol FinishRegProtocol {
    var isFullyRegistered: Bool { get }
    var delegate: FinishRegDelegate? { get set }

//    func fullyRegister(code: String)
}

// MARK: - VIEW MODEL
class FinishRegViewModel: FinishRegProtocol {
    
    var isFullyRegistered: Bool = false
    weak var delegate: FinishRegDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }

//    func fullyRegister(code: String) {
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
//                    self.delegate?.didSucceed(withData: data)
//
//                case .failure(let error):
//                    print("OTP fail: \(error)")
//                    self.isVerified = false
//                    self.delegate?.didFail(withError: error)
//                }
//            }
//        }
//    }
    
}
