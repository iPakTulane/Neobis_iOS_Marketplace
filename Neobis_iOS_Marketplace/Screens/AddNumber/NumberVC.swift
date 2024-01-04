//
//  NumberVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit


// MARK: - VIEW CONTROLLER
class NumberViewController: UIViewController {
    
    let mainView = NumberView()
    var mainViewModel: NumberProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(numberProtocol: NumberProtocol) {
        self.mainViewModel = numberProtocol
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupNavigationView()
    }
    
    // MARK: - UI SETUP
    func setupNavigationView() {
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addTargets() {
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }
    
    // MARK: - ACTION BUTTONS
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enterPressed() {
        if let text = mainView.numberField.text {
            var digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            if let firstDigit = digits.first {
                digits.removeFirst()
                print(firstDigit)
            }
            
            digits = "+998" + digits
            
            mainViewModel.fullRegister(phone_number: digits)
        }
    }
    
    // MARK: - NAVIGATION
    func handleFullRegistrationSuccess(_ data: Data) {

        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen

        if let viewControllers = vc.viewControllers {
            let lastIndex = viewControllers.count - 1
            vc.selectedIndex = lastIndex
        }

        present(vc, animated: true, completion: nil)
    }
    
    func handleFullRegistrationFailure(_ error: Error) {
        mainView.errorLabel.isHidden = false
        print("Full registration failed with error: \(error)")
    }
}

// MARK: - EXTENSION
extension NumberViewController: NumberDelegate {
    // MARK: - NUMBER DELEGATE METHODS
    func registrationDidSucceed(withData data: Data) {
        handleFullRegistrationSuccess(data)
    }
    
    func registrationDidFail(withError error: Error) {
        handleFullRegistrationFailure(error)
    }
}
