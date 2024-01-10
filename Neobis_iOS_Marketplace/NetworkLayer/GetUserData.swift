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
protocol UserProtocol {
    func fetchUserData(completion: @escaping (Result<GetUserResponse, Error>) -> Void)
}

// MARK: - VIEW MODEL
class GetUserViewModel: UserProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    
    func fetchUserData(completion: @escaping (Result<GetUserResponse, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else {
            return
        }
        
        let url = apiService.baseURL + APIEndpoint.userData.rawValue
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: GetUserResponse.self) { response in
            switch response.result {
                
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}



