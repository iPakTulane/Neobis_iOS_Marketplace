//
//  ProductResponse.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 05/01/24.
//


import Foundation

struct ProductResponse : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let available : Bool?
    let photo : String?
    let short_description : String?
    let price : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case available = "available"
        case photo = "photo"
        case short_description = "short_description"
        case price = "price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        available = try values.decodeIfPresent(Bool.self, forKey: .available)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        short_description = try values.decodeIfPresent(String.self, forKey: .short_description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
    }

}


