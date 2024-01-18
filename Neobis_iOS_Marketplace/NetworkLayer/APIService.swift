//
//  Service.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class APIService {
    
//    static let shared = APIService()
//    private init() {}
    
    // MARK: - BASE URL
    let baseURL = "https://aibek-backender.org.kg/"
        
    // MARK: - POST
    func post<T: Decodable>(
        endpoint: String,
        parameters: [String: Any],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
//            let url = baseURL + endpoint
            guard let url = URL(string: baseURL + endpoint) else { return }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, 
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    // MARK: - POST IMAGE + TOKEN @ NUMBER VM
    func postWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
            
            guard let url = URL(string: baseURL + endpoint) else { return }
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(bearerToken)"
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameters {
                        if key != "avatar", let data = (value as? String)?.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                    
                    if let photoData = parameters["avatar"] as? Data {
                        let photoString = photoData.base64EncodedString()
                        if let photoStringData = photoString.data(using: .utf8) {
                            multipartFormData.append(photoStringData, withName: "avatar")
                        }
                    }
                },
                to: url,
                method: .post,
                headers: headers
            ).responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    
    // MARK: - POST IMAGE + TOKEN @ ADD PRODUCT VM
//    func postImagesWithBearerToken(
//        endpoint: String,
//        parameters: [String: Any],
//        imageDatas: [Data],
//        bearerToken: String,
//        completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
//            
////            let url = baseURL + endpoint
//            guard let url = URL(string: baseURL + endpoint) else { return }
//            let boundary = "Boundary-\(UUID().uuidString)"
//            let mimeType = "image/*"
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer \(bearerToken)",
//                "Content-Type": "multipart/form-data; boundary=\(boundary)"
//            ]
//            
//            AF.upload(multipartFormData: { multipartFormData in
//                    for (key, value) in parameters {
//                        if let stringValue = "\(value)".data(using: .utf8) {
//                            multipartFormData.append(stringValue, withName: key)
//                        }
//                    }
//                    
//                    for (index, imageData) in imageDatas.enumerated() {
//                        let fileName = "image\(index).jpeg"
//                        let fieldName = "images"
//                        
//                        multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
//                    }
//                },
//                to: url,
//                method: .post,
//                headers: headers
//            )
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    if let data = data {
//                        do {
//                            // Decode the JSON response into a ProductResponse object
//                            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
//                            completion(.success(productResponse))
//                        } catch {
//                            // Handle decoding error
//                            completion(.failure(error.localizedDescription))
//                        }
//                    } else {
//                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
//                        completion(.failure(error.localizedDescription))
//                    }
//                case .failure(let error):
//                    completion(.failure(error.localizedDescription))
//                }
//            }
//        }

    
    
    //    func postImagesWithBearerToken(
//        endpoint: String,
//        parameters: [String: Any],
//        imageDatas: [Data],
//        bearerToken: String,
//        completion: @escaping (Result<ProductResponse, Error>) -> Void) {
//
//        guard let url = URL(string: baseURL + endpoint) else { return }
//        let boundary = "Boundary-\(UUID().uuidString)"
//        let mimeType = "image/*"
//
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(bearerToken)",
//            "Content-Type": "multipart/form-data; boundary=\(boundary)"
//        ]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                if let stringValue = "\(value)".data(using: .utf8) {
//                    multipartFormData.append(stringValue, withName: key)
//                }
//            }
//
//            for (index, imageData) in imageDatas.enumerated() {
//                let fileName = "image\(index).jpeg"
//                let fieldName = "images"
//
//                multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
//            }
//        },
//        to: url,
//        method: .post,
//        headers: headers)
//        .response { response in
//            switch response.result {
//            case .success(let data):
//                if let data = data {
//                    do {
//                        // Decode the JSON response into a ProductResponse object
//                        let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
//                        completion(.success(productResponse))
//                    } catch {
//                        // Handle decoding error
//                        completion(.failure(error.localizedDescription))
//                    }
//                } else {
//                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
//                    completion(.failure(error.localizedDescription))
//                }
//            case .failure(let error):
//                completion(.failure(error.localizedDescription))
//            }
//        }
//    }

    func postImagesWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        imageDatas: [Data],
        bearerToken: String,
        completion: @escaping (Result<[ProductResponse], Error>) -> Void) {

        guard let url = URL(string: baseURL + endpoint) else { return }
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let stringValue = "\(value)".data(using: .utf8) {
                    multipartFormData.append(stringValue, withName: key)
                }
            }

            for (index, imageData) in imageDatas.enumerated() {
                let fileName = "image\(index).jpeg"
                let fieldName = "images"

                multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
            }
        },
        to: url,
        method: .post,
        headers: headers)
        .responseDecodable(of: [ProductResponse].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    // MARK: - PUT IMAGE + TOKEN
    
//    func putImagesWithBearerToken(
//        endpoint: String,
//        parameters: [String: Any],
//        imageDatas: [Data],
//        bearerToken: String,
        
        
    func putImagesWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        imageDatas: [Data],
        bearerToken: String,
        
        //        completion: @escaping (Result<Data, Error>) -> Void) {

    
    //        completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
//
////            let url = baseURL + endpoint
//            guard let url = URL(string: baseURL + endpoint) else { return }
//            let boundary = "Boundary-\(UUID().uuidString)"
//            let mimeType = "image/*"
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer \(bearerToken)",
//                "Content-Type": "multipart/form-data; boundary=\(boundary)"
//            ]
//            
//            AF.upload(multipartFormData: { multipartFormData in
//                    for (key, value) in parameters {
//                        if let stringValue = "\(value)".data(using: .utf8) {
//                            multipartFormData.append(stringValue, withName: key)
//                        }
//                    }
//                    
//                    for (index, imageData) in imageDatas.enumerated() {
//                        let fileName = "image\(index).jpeg"
//                        let fieldName = "images"
//                        
//                        multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
//                    }
//                },
//                to: url,
//                method: .put,
//                headers: headers
//            )
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    if let data = data {
//                        do {
//                            // Decode the JSON response into a ProductResponse object
//                            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
//                            completion(.success(productResponse))
//                        } catch {
//                            // Handle decoding error
//                            completion(.failure(error.localizedDescription))
//                        }
//                    } else {
//                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
//                        completion(.failure(error.localizedDescription))
//                    }
//                case .failure(let error):
//                    completion(.failure(error.localizedDescription))
//                }
//            }
//            
//        }
    
//        completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
//            //            let url = baseURL + endpoint
//            guard let url = URL(string: baseURL + endpoint) else { return }
//            let boundary = "Boundary-\(UUID().uuidString)"
//            let mimeType = "image/*"
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer \(bearerToken)",
//                "Content-Type": "multipart/form-data; boundary=\(boundary)"
//            ]
//            
//            AF.upload(multipartFormData: { multipartFormData in
//                for (key, value) in parameters {
//                    if let stringValue = "\(value)".data(using: .utf8) {
//                        multipartFormData.append(stringValue, withName: key)
//                    }
//                }
//                
//                for (index, imageData) in imageDatas.enumerated() {
//                    let fileName = "image\(index).jpeg"
//                    let fieldName = "images"
//                    
//                    multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
//                }
//            },
//            to: url,
//            method: .put,
//            headers: headers)
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    if let data = data {
//                        do {
//                            // Decode the JSON response into an array of ProductResponse objects
//                            let productResponses = try JSONDecoder().decode([ProductResponse].self, from: data)
//                            completion(.success(productResponses))
//                        } catch {
//                            // Handle decoding error
//                            completion(.failure(error.localizedDescription))
//                        }
//                    } else {
//                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
//                        completion(.failure(error.localizedDescription))
//                    }
//                case .failure(let error):
//                    completion(.failure(error.localizedDescription))
//                }
//            }
//            // ... (remaining code)
//        }
    
    
//    func putImagesWithBearerToken(
//        endpoint: String,
//        parameters: [String: Any],
//        imageDatas: [Data],
//        bearerToken: String,
        completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
        
        guard let url = URL(string: baseURL + endpoint) else { return }
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let stringValue = "\(value)".data(using: .utf8) {
                    multipartFormData.append(stringValue, withName: key)
                }
            }
            
            for (index, imageData) in imageDatas.enumerated() {
                let fileName = "image\(index).jpeg"
                let fieldName = "images"
                
                multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
            }
        },
        to: url,
        method: .put,
        headers: headers)
        .responseDecodable(of: [ProductResponse].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - DELETE ITEM @ PRODUCT VM
    func deleteData(
        id: Int,
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
            
            let endpoint = "product/\(id)/"
            let url = baseURL + endpoint
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(bearerToken)"
            ]
            
            AF.request(url, method: .delete, headers: headers)
                .validate(statusCode: 200..<400)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        if let data = data {
                            completion(.success(data))
                            print("Delete success")
                        } else {
                            print("Delete successfull")
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    
    // MARK: - GET ITEMS DATA @ HOME & PRODUCT VM
    
    func getProductData<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            let method = HTTPMethod(rawValue: method.rawValue)
            
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       headers: headers).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    
    // MARK: - PROFILE + ...
    
    // TODO: to rename for getUserData
    func getUserData<T: Decodable>(
        url: String,
        headers: HTTPHeaders,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let accessToken = TokenManager.shared.accessToken else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
                
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
}


