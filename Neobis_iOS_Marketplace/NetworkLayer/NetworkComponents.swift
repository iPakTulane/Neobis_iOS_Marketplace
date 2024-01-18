//
//  NetworkComponents.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation

enum APIEndpoint: String {
    case login = "auth/login/"
    case register = "auth/register/"
    case fullRegister = "account/full_register/"
    case getUserData = "auth/profile-view/"
    case updateUserData = "auth/profile-update/"
    case otp = "auth/code-check/"
    // TODO: check on appropriate HTTPMethod
    case product = "products/create-update-list/"
}

//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//    case patch = "PATCH"
//    case delete = "DELETE"
//}
