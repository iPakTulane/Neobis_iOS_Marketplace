//
//  HomeVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

//import Foundation
//
//// MARK: - DELEGATE PROTOCOL
//protocol HomeDelegate: AnyObject {
//    func homeDidSucceed(withData data: ProductResponse)
//    func homeDidFail(withError error: Error)
//}
//
//// MARK: - PROTOCOL
//protocol HomeProtocol {
//    var isHome: Bool { get }
//    var delegate: HomeDelegate? { get set }
//
//    func displayProducts()
//}
//
//// MARK: - VIEW MODEL
//class HomeViewModel: HomeProtocol {
//    
//    var isHome: Bool = false
//    weak var delegate: HomeDelegate?
//    
//    let apiService: APIService
//    
//    init() {
//        self.apiService = APIService()
//    }
//
////    func displayProducts() {
////        
////        apiService.getProductData() { [weak self] result in
////            switch result {
////                
////            case .success(let homeData):
////                print(homeData)
////                // TODO: Update home screen with homeData
////                }
////                
////            case .failure(let error):
////                print("Failed to get product data at home:", error)
////            }
////        }
//        
//    func displayProducts() {
//        
//        apiService.getProductData(
//            headers: <#T##HTTPHeaders#>) completion: <#T##(Result<[ProductResponse], Error>) -> Void#>)
//        
//        
//        post(endpoint: APIEndpoint.otp.rawValue, parameters: parameters, responseType: ProductResponse.self) 
//        
//        { result in
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
//}
import Foundation
import Alamofire

// MARK: - DELEGATE PROTOCOL
protocol HomeDelegate: AnyObject {
    func homeDidSucceed(withData data: ProductResponse)
    func homeDidFail(withError error: Error)
}

// MARK: - PROTOCOL
protocol HomeProtocol {
    var isEmpty: Bool { get }
    var delegate: HomeDelegate? { get set }

    func fetchProductData(completion: @escaping (Result<ProductResponse, Error>) -> Void)

    // TODO: 
    //    func addProduct()
}

// MARK: - VIEW MODEL
class HomeViewModel: HomeProtocol {
    
    var isEmpty: Bool = true
    var delegate: HomeDelegate?
        
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchProductData(completion: @escaping (Result<ProductResponse, Error>) -> Void) {

        guard let accessToken = TokenManager.shared.accessToken else {
//            let error = NSError(domain: "AuthorizationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
//            completion(.failure(error))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        apiService.getProductData(
            headers: headers,
            responseType: ProductResponse.self) { result in
            switch result {
                
            case .success(let data):
                print("Home success")
                self.isEmpty = false
                self.delegate?.homeDidSucceed(withData: data)
                
//                do {
//                    // Convert response array to [[String: Any]]
//                    let dataArray = try data.map { try JSONSerialization.jsonObject(with: JSONEncoder().encode($0), options: .allowFragments) as? [String: Any] ?? [:] }
//                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray, options: .prettyPrinted)
//                    let jsonString = String(data: jsonData, encoding: .utf8)
//                    print(jsonString ?? "")
//                    completion(.success(dataArray))
//                } catch {
//                    completion(.failure(error))
//                }
                
            case .failure(let error):
//                completion(.failure(error))
                print("Home fail: \(error)")
                self.isEmpty = true
                self.delegate?.homeDidFail(withError: error)
            }
        }
    }
    
    // TODO:
//    func addProduct() {
//        // TODO: To go to AddProduct screen
//    }
    
}
