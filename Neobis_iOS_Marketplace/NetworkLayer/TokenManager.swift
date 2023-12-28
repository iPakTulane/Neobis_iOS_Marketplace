//
//  TokenManager.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation

class TokenManager {
    
    static let shared = TokenManager()
    
    // Save access token
    private let accessTokenKey = "AccessToken"
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    // Save refresh token
    private let refreshTokenKey = "RefreshToken"
    
    var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    private init() {}
    
}
