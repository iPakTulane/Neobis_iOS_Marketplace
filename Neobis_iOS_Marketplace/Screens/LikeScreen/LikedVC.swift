//
//  LikedVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class LikedViewController: UIViewController {
    
    let containView = LikedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Понравившиеся"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        setupView()
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(containView)
        
        containView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
