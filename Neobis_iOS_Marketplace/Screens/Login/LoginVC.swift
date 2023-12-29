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
    var loginProtocol: LoginProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(loginProtocol: LoginProtocol) {
        self.loginProtocol = loginProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        handleResult()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func addTargets() {
        mainView.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    @objc func enterButtonPressed() {
        if mainView.enterButton.backgroundColor != UIColor.colorGrey {
            guard let name = mainView.nameField.text,
                  let password = mainView.passwordField.text
            else {
                print("Email or password is empty.")
                return
            }
            loginProtocol.login(username: name, password: password)
        }
    }
    
    @objc func registerButtonPressed() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - NAVIGATION
    func handleResult() {
        loginProtocol.loginResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccessfulLogin(data)
                case .failure(let error):
                    self?.handleLoginFailure(error)
                }
            }
        }
    }
    
    func handleSuccessfulLogin(_ data: Data) {
        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func handleLoginFailure(_ error: Error) {
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
