//
//  OTPVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

// TODO:
class OTPViewController: UIViewController {
        
    let mainView = OTPView()
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}
