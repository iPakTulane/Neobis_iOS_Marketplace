//
//  OTPResponse.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 08/01/24.
//

import Foundation

struct OTPResponse : Codable {
    let message : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
