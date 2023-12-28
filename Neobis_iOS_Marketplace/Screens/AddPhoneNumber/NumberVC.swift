//
//  NumberVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class NumberViewController: UIViewController {
        
    let mainView = NumberView()
    var numberProtocol: NumberProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(numberProtocol: NumberProtocol!) {
        self.numberProtocol = numberProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        numberProtocol.registerResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccessfulRegister(data)
                case .failure(let error):
                    self?.handleLoginFailure(error)
                }
            }
        }
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
            }
            
            digits = "+996" + digits
            
            numberProtocol.fullRegister(phone_number: digits)
        }
    }
    
    // MARK: - NAVIGATION
    func handleSuccessfulRegister(_ data: Data) {

        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        
        if let viewControllers = vc.viewControllers {
            let lastIndex = viewControllers.count - 1
            vc.selectedIndex = lastIndex
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func handleLoginFailure(_ error: Error) {
        
        mainView.errorLabel.isHidden = false
        print("Login failed with error: \(error)")
    }
        
}
