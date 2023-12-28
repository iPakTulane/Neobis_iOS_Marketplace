//
//  Service.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation
import UIKit
import Alamofire

class APIService {
    
    // MARK: - BASE URL
    let baseURL = "https://aibek-backender.org.kg/"
    
    // MARK: - POST
    func post(
        endpoint: String,
        parameters: [String: Any],
        completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200...299 ~= statusCode {
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(statusCode)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - POST with token
    func postWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + endpoint) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let data = (value as? String)?.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
                
                if let photoData = parameters["photo"] as? Data {
                    multipartFormData.append(photoData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
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
    
    // MARK: - POST images with token
    func postImagesWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        imageDatas: [Data],
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = baseURL + endpoint
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
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
            headers: headers
        )
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - PUT images with token
    
    func putImagesWithBearerToken(
        endpoint: String,
        parameters: [String: Any],
        imageDatas: [Data],
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = baseURL + endpoint
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
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
            headers: headers
        )
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    // MARK: - GET product
    func fetchProductData(
        headers: HTTPHeaders,
        completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        
        AF.request("http://16.16.200.195/api/v1/product/", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let dataArray = value as? [[String: Any]] {
                    completion(.success(dataArray))
                } else {
                    let error = NSError(domain: "ProductDataParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse product data"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - GET with token
    func getWithBearerToken(
        endpoint: String,
        bearerToken: String,
        completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = URL(string: "http://16.16.200.195/api/v1/" + endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - DELETE
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

}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
