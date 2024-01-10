//
//  PasswordVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    var username = ""
    var email = ""
    
    let mainView = PasswordView()
    var mainViewModel: PasswordProtocol!
    
    override func loadView() {
        view = mainView
    }
    
    init(registerProtocol: PasswordProtocol) {
        self.mainViewModel = registerProtocol
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel.delegate = self
    }
    
    // MARK: - INIT
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        addTargets()
        addDelegates()
    }
    
    func setupNavigationView() {
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let eyeButton = UIBarButtonItem(image: UIImage(named: "eye-switch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(eyeButtonPressed))
        self.navigationItem.rightBarButtonItem = eyeButton
        
        title = "Registration"
    }
    
    func addTargets() {
        mainView.finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        mainView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    func addDelegates() {
        mainView.passwordField.delegate = self
        mainView.passwordConfirmField.delegate = self
//        mainViewModel.delegate = self
    }
    
    @objc func finishButtonPressed() {
        if mainView.passwordField.text == mainView.passwordConfirmField.text {
            mainViewModel.register(
                password: mainView.passwordField.text!,
                password_confirm: mainView.passwordConfirmField.text!)
        }
    }
    
    
    @objc func nextButtonPressed() {
        if mainView.nextButton.backgroundColor == UIColor.colorBlue {
            mainView.nextButton.isHidden = true
            mainView.finishButton.isHidden = false
            mainView.passwordConfirmField.isHidden = false
            mainView.passwordLabel.text = "Confirm password"
            mainView.passwordConfirmField.becomeFirstResponder()
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func eyeButtonPressed() {
        mainView.passwordField.isSecureTextEntry = !mainView.passwordField.isSecureTextEntry
        mainView.passwordConfirmField.isSecureTextEntry = !mainView.passwordConfirmField.isSecureTextEntry
    }
    
}

// MARK: - TEXTFIELD DELEGATE
extension PasswordViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedPassword1 = textField == mainView.passwordField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.passwordField.text
        
        let updatedPassword2 = textField == mainView.passwordConfirmField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.passwordConfirmField.text
        
        if let password1 = updatedPassword1 {
            mainView.nextButton.isEnabled = password1.count >= 8
            
            if mainView.nextButton.isEnabled {
                mainView.nextButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.nextButton.backgroundColor = UIColor.colorGrey
            }
        }
        
        if let password2 = updatedPassword2 {
            mainView.finishButton.isEnabled = password2.count >= 8
            
            if mainView.finishButton.isEnabled {
                mainView.finishButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.finishButton.backgroundColor = UIColor.colorGrey
            }
        }
        
        return true
    }
    
}

// MARK: - PASSWORD DELEGATE
extension PasswordViewController: PasswordDelegate {
    func didSucceed(withData data: RegisterResponse) {
        print("Registration successful")
        let vc = LoginViewController(loginProtocol: LoginViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFail(withError error: Error) {
        mainView.passwordError.isHidden = false
        mainView.passwordField.textColor = UIColor.сolorRed
        mainView.passwordConfirmField.textColor = UIColor.сolorRed
        print("Registration failed with error: \(error)")
    }
}
