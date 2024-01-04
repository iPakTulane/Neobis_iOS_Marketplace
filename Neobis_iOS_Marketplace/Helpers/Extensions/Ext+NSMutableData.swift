//
//  Ext+NSMutableData.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 04/01/24.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
