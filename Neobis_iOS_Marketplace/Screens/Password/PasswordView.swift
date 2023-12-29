//
//  PasswordView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class PasswordView: UIView, UITextFieldDelegate {
    
    // MARK: - UI COMPONENTS
    let lockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lock")
        return image
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter password"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let passwordReq: UILabel = {
        let label = UILabel()
        label.text = "At least — 8 symbols.\n For security, a password needs \nto have both letters and digits."
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor.colorGrey
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 24)
        field.isSecureTextEntry = true
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        return field
    }()
    
    let passwordConfirmField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 24)
        field.isSecureTextEntry = true
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.isHidden = true
        return field
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23 * UIScreen.main.bounds.height / 812
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        return button
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23 * UIScreen.main.bounds.height / 812
        button.setTitle("Finish", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.isHidden = true
        return button
    }()
    
    let passwordError: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Passwords don't match"
        label.textColor = UIColor.сolorRed
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
        passwordField.delegate = self
        passwordConfirmField.delegate = self
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - ACTION BUTTONS
    @objc func enterButtonPressed() {
        if enterButton.backgroundColor == UIColor.colorBlue {
            enterButton.isHidden = true
            finishButton.isHidden = false
            passwordConfirmField.isHidden = false
            passwordLabel.text = "Repeat password"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - UI SETUP
    func setupViews() {
        addSubview(lockImage)
        addSubview(passwordLabel)
        addSubview(passwordReq)
        addSubview(enterButton)
        addSubview(finishButton)
        addSubview(passwordField)
        addSubview(passwordConfirmField)
        addSubview(passwordError)
    }
    
    func setupConstraints() {
        lockImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(120 * UIScreen.main.bounds.height / 812)
            make.centerX.equalToSuperview()
        }
        
        passwordLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(228 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(565 * UIScreen.main.bounds.height / 812)
            make.centerX.equalToSuperview()
        }
        
        passwordReq.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(255 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(500 * UIScreen.main.bounds.height / 812)
            make.centerX.equalToSuperview()
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(497 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(271 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        finishButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(497 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(271 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        passwordField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(340 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(438 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(95.5 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(95.5 * UIScreen.main.bounds.width / 375)
        }
        
        passwordConfirmField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(382 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(396 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(95.5 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(95.5 * UIScreen.main.bounds.width / 375)
        }
        
        passwordError.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(424 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(368 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
        }
    }
    
    // MARK: - TEXTFIELD DELEGATE
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedPassword1 = textField == passwordField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : passwordField.text
        
        let updatedPassword2 = textField == passwordConfirmField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : passwordConfirmField.text
        
        if let password1 = updatedPassword1 {
            enterButton.isEnabled = password1.count >= 8
            
            if enterButton.isEnabled {
                enterButton.backgroundColor = UIColor.colorBlue
            } else {
                enterButton.backgroundColor = UIColor.colorGrey
            }
        }
        
        if let password2 = updatedPassword2 {
            finishButton.isEnabled = password2.count >= 8
            
            if finishButton.isEnabled {
                finishButton.backgroundColor = UIColor.colorBlue
            } else {
                finishButton.backgroundColor = UIColor.colorGrey
            }
        }
        
        return true
    }
}
