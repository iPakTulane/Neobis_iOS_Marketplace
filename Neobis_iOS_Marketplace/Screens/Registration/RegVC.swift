//
//  RegVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
        
    let mainView = RegistrationView()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        addTargets()
    }

    func addTargets() {
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    func setupNavigationView() {
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        title = "Registration"
    }
    
    // MARK: - ACTION BUTTONS
    @objc func enterButtonPressed() {
        
        if mainView.enterButton.backgroundColor != UIColor.colorGrey {
            guard let userName = mainView.nameField.text else { return }
            guard let email = mainView.mailField.text else { return }
            
            let vc = PasswordViewController(registerProtocol: PasswordViewModel(userName: userName, email: email))
            vc.username = mainView.nameField.text ?? ""
            vc.email = mainView.mailField.text ?? ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }

}

