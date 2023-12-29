//
//  BorderedTextField.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//

import Foundation
import UIKit
import SnapKit

class BorderedTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.sublayers?.forEach { if $0.name == "bottomLine" { $0.removeFromSuperlayer() } }
        
        font = UIFont(name: "GothamPro-Medium", size: 16)
        
        let bottomLine = CALayer()
        bottomLine.name = "bottomLine"
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        bottomLine.backgroundColor = UIColor.colorBackground.cgColor
        layer.addSublayer(bottomLine)
    }
    
}

