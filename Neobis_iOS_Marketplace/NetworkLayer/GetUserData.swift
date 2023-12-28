//
//  GetUserData.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation
import Foundation
import Alamofire

// MARK: - PROTOCOL
protocol GetUserProtocol {
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void)
}

// MARK: - VIEW MODEL
class GetUserViewModel: GetUserProtocol {

    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request("https://aibek-backender.org.kg/auth/profile-view/", headers: headers).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                
                if let userData = value as? [String: Any] {
                    completion(.success(userData))
                    
                } else {
                    let error = NSError(domain: "UserDataParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data"])
                    completion(.failure(error))
                }
            
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
