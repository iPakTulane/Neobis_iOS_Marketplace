//
//  RegisterResponse.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 05/01/24.
//

import Foundation

struct RegisterResponse : Codable {
    let username : String?
    let email : String?

    enum CodingKeys: String, CodingKey {

        case username = "username"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}
