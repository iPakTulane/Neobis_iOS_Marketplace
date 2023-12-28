//
//  NumberVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//


import Foundation
import Alamofire

// MARK: - PROTOCOL
protocol NumberProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func fullRegister(phone_number: String)
}

// MARK: - VIEW MODEL
class NumberViewModel: NumberProtocol {
    
    var isRegistered: Bool = false
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    private let first_name: String
    private let last_name: String
    private let birthday: String
    private let photo: Data
    
    init(first_name: String ,last_name: String, birthday: String, photo: Data) {
        self.apiService = APIService()
        self.first_name = first_name
        self.last_name = last_name
        self.birthday = birthday
        self.photo = photo
    }
    
    func fullRegister(phone_number: String) {
        let endpoint = "account/full_register/"
        
        let parameters: [String: Any] = [
            "first_name": first_name,
            "last_name": last_name,
            "birthday": birthday,
            "phone_number": phone_number,
            "photo": photo
        ]
        
        apiService.postWithBearerToken(
            endpoint: endpoint,
            parameters: parameters,
            bearerToken: TokenManager.shared.accessToken ?? "") { [weak self] result in
                
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isRegistered = true
                    self?.registerResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed to register number: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isRegistered = false
                    self?.registerResult?(.failure(error))
                }
            }
        }
    }
    
}
