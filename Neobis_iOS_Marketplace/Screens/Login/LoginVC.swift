//
//  LoginVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
        
    lazy var mainView = LoginView()
    var mainViewModel: LoginProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(loginProtocol: LoginProtocol) {
        self.mainViewModel = loginProtocol
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        addDelegates()
    }
    

    // MARK: - UI SETUP
    func addDelegates() {
        mainView.nameField.delegate = self
        mainView.passwordField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func addTargets() {
        mainView.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        mainView.passwordField.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    @objc func enterButtonPressed() {
        if mainView.enterButton.backgroundColor != UIColor.colorGrey {
            guard let name = mainView.nameField.text,
                  let password = mainView.passwordField.text
            else {
                print("Email or password is empty.")
                return
            }
            mainViewModel.login(username: name, password: password)
        }
    }
    
    @objc func registerButtonPressed() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
        
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    // Password visibility
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        mainView.passwordField.isSecureTextEntry = !mainView.passwordField.isSecureTextEntry
    }
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

            let updatedName = textField == mainView.nameField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.nameField.text
            let updatedPassword = textField == mainView.passwordField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.passwordField.text
        
        if let name = updatedName, let password = updatedPassword {
            
            mainView.enterButton.isEnabled = name.count >= 3 && password.count >= 8
            
            if mainView.enterButton.isEnabled {
                mainView.enterButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.enterButton.backgroundColor = UIColor.colorGrey
            }
        }
        return true
    }
    
}

// MARK: - LOGIN DELEGATE
extension LoginViewController: LoginDelegate {
    
    func loginDidSucceed(withData data: Data) {
        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func loginDidFail(withError error: Error) {
        mainView.statusLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mainView.statusLabel.isHidden = true
        }
        
        mainView.nameField.textColor = UIColor.сolorRed
        mainView.passwordField.textColor = UIColor.сolorRed
        mainView.nameLine.backgroundColor = UIColor.сolorRed
        mainView.passwordLine.backgroundColor = UIColor.сolorRed
        print("Login failed with error: \(error)")
    }
    
}
