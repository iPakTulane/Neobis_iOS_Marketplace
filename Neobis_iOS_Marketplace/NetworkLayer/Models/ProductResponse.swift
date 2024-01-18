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
    let short_description : String?
    let available : Bool?
    let price : String?
    let photos : [Photos]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case short_description = "short_description"
        case available = "available"
        case price = "price"
        case photos = "photos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        short_description = try values.decodeIfPresent(String.self, forKey: .short_description)
        available = try values.decodeIfPresent(Bool.self, forKey: .available)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
    }

}

struct Photos : Codable {
    let id : Int?
    let photo : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case photo = "photo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
    }

}
