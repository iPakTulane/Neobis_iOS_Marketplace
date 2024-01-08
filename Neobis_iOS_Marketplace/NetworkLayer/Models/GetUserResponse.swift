//
//  GetAuthProfileView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 05/01/24.
//

import Foundation


// GetAuthProfileView

struct GetUserResponse : Codable {
    let avatar : String?
    let username : String?
    let email : String?
    let first_name : String?
    let last_name : String?
    let date_of_birth : String?
    let phone_number : String?

    enum CodingKeys: String, CodingKey {

        case avatar = "avatar"
        case username = "username"
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case date_of_birth = "date_of_birth"
        case phone_number = "phone_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
    }

}



