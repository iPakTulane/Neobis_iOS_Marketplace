//
//  Ext+UIImage.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 05/01/24.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizedImage(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func compressedImage(withQuality quality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: quality.rawValue)
    }
}

enum JPEGQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
}
