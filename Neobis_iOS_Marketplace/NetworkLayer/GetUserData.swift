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
    func fetchUserData(completion: @escaping (Result<UserResponse, Error>) -> Void)
}

// MARK: - VIEW MODEL
class GetUserViewModel: GetUserProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    
    func fetchUserData(completion: @escaping (Result<UserResponse, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else {
            return
        }
        
        let url = "https://aibek-backender.org.kg/auth/profile-view/"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: UserResponse.self) { response in
            switch response.result {
                
            case .success(let userResponse):
                completion(.success(userResponse))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}



