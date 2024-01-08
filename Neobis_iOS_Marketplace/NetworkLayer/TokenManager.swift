//
//  TokenManager.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation


class TokenManager {
    
    static let shared = TokenManager()
    
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    
    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: accessTokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: accessTokenKey) }
    }
    
    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: refreshTokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: refreshTokenKey) }
    }

    func saveAccessToken(name: String?) {
        UserDefaults.setValue(name, forKey: accessTokenKey)
    }
    
    func saveRefreshToken(name: String?) {
        UserDefaults.setValue(name, forKey: refreshTokenKey)
    }
    
    private init() {}
    
    
}


//
//import KeychainSwift
//
//class TokenManager {
//    static let shared = TokenManager()
//    private let keychain = KeychainSwift()
//
//    var accessToken: String? {
//        get {
//            return keychain.get("accessToken")
//        }
//        set {
//            if let newValue = newValue {
//                keychain.set(newValue, forKey: "accessToken")
//            } else {
//                keychain.delete("accessToken")
//            }
//        }
//    }
//
//    var refreshToken: String? {
//        get {
//            return keychain.get("refreshToken")
//        }
//        set {
//            if let newValue = newValue {
//                keychain.set(newValue, forKey: "refreshToken")
//            } else {
//                keychain.delete("refreshToken")
//            }
//        }
//    }
//}
