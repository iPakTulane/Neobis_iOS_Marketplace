//
//  OTPVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//


import UIKit
import SnapKit

class OTPViewController: UIViewController {
        
    lazy var mainView = OTPView()
    var mainViewModel: OTPProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: OTPProtocol) {
        self.mainViewModel = viewModel
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
        mainView.codeField.delegate = self
    }
    
    func addTargets() {
        mainView.newCodeButton.addTarget(self, action: #selector(newCodeButtonPressed), for: .touchUpInside)
    }
    
    @objc func newCodeButtonPressed() {
        // TODO:
        mainViewModel.verify(code: "1234")
    }
    
}

// MARK: - UITextFieldDelegate
extension OTPViewController: UITextFieldDelegate {
    
}

// MARK: - LOGIN DELEGATE
extension OTPViewController: OTPDelegate {

    func didSucceed(withData data: OTPResponse) {
        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func didFail(withError error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mainView.errorLabel.isHidden = true
        }
        mainView.errorLabel.textColor = UIColor.сolorRed
        print("OTP failed with error: \(error)")
    }
    
}
