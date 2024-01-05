//
//  TokenManager.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation


class TokenManager {
    
//    var storage: UserDefaults
    
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


