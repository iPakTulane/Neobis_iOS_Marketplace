//
//  String+Ext.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation

extension String {
    func countOccurences(of searchString: String, in range: NSRange) -> Int {
        let substring = (self as NSString).substring(with: range)
        return substring.components(separatedBy: searchString).count - 1
    }
}
