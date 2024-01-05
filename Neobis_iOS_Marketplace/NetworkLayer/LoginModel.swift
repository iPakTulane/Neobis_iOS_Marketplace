//
//  LoginModel.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 05/01/24.
//

import Foundation

struct LoginModel: Codable {
    let username : String?
    let tokens : Tokens?

    enum CodingKeys: String, CodingKey {

        case username = "username"
        case tokens = "tokens"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        tokens = try values.decodeIfPresent(Tokens.self, forKey: .tokens)
    }

}


import Foundation
struct Tokens : Codable {
    let refresh : String?
    let access : String?

    enum CodingKeys: String, CodingKey {

        case refresh = "refresh"
        case access = "access"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        refresh = try values.decodeIfPresent(String.self, forKey: .refresh)
        access = try values.decodeIfPresent(String.self, forKey: .access)
    }

}

