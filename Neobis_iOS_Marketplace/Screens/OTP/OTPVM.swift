//
//  OTPVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation

// MARK: - DELEGATE PROTOCOL
protocol OTPDelegate: AnyObject {
    func otpDidSucceed(withData data: OTPResponse)
    func otpDidFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol OTPProtocol {
    var isVerified: Bool { get }

    var delegate: OTPDelegate? { get set }

    func verify(code: String)
}

// MARK: - VIEW MODEL
class OTPViewModel: OTPProtocol {
    
    var isVerified: Bool = false
    
    weak var delegate: OTPDelegate?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }

    func verify(code: String) {
        
        let parameters: [String: Any] = [
            "code": code
        ]
        
        apiService.post(endpoint: APIEndpoint.otp.rawValue, parameters: parameters, responseType: OTPResponse.self) { result in
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    print(data)
                    self.isVerified = true
                    self.delegate?.otpDidSucceed(withData: data)

                case .failure(let error):
                    print("OTP fail: \(error)")
                    self.isVerified = false
                    self.delegate?.otpDidFail(withError: error)
                }
            }
        }
    }
}
