//
//  Constants.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 29/12/23.
//


import UIKit

struct Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    static func relativeWidth(_ value: CGFloat) -> CGFloat {
        return value * width / 375
    }
    
    static func relativeHeight(_ value: CGFloat) -> CGFloat {
        return value * height / 812
    }
}
