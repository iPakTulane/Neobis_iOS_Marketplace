//
//  RegVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    var username = ""
    var email = ""
    
    let mainView = RegistrationView()
    
    // MARK: - UI SETUP
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        addTargets()
        addDelegates()
    }
    
    func addDelegates() {
        mainView.nameField.delegate = self
        mainView.mailField.delegate = self
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

// MARK: - EXTENSION
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            let updatedName = textField == mainView.nameField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.nameField.text
            
            let updatedMail = textField == mainView.mailField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.mailField.text
            
            if let name = updatedName,
               let mail = updatedMail {
                
                mainView.enterButton.isEnabled = name.count >= 3 && mail.contains("@") && mail.contains(".com")
                
                if mainView.enterButton.isEnabled {
                    mainView.enterButton.backgroundColor = UIColor.colorBlue
                } else {
                    mainView.enterButton.backgroundColor = UIColor.colorGrey
                }
            }
            return true
        }
}
