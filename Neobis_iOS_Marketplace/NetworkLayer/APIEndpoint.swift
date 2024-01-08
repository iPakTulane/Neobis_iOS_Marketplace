//
//  APIEndpoint.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation

enum APIEndpoint: String {
    case login = "auth/login/"
    case register = "auth/register/"
    case fullRegister = "account/full_register/"
    case userData = "auth/profile-view/"
    case otp = "auth/code-check/"
    case product = "products/create-update-list/"
}
