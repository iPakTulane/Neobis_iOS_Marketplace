//
//  PasswordView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class PasswordView: UIView {
    
    // MARK: - UI COMPONENTS
    lazy var lockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lock")
        return image
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter password"
        label.font = UIFont(name: "GothamPro-Medium", size: 25)
        label.textColor = .black
        return label
    }()
    
    lazy var passwordReq: UILabel = {
        let label = UILabel()
        label.text = "At least - 8 symbols.\n To ensure security, a password \nneeds to have both letters and digits."
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor.colorGrey
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.font = UIFont.boldSystemFont(ofSize: 30)
        field.isSecureTextEntry = true
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.becomeFirstResponder()
        return field
    }()
    
    lazy var passwordConfirmField: UITextField = {
        let field = UITextField()
        field.font = UIFont.boldSystemFont(ofSize: 30)
        field.isSecureTextEntry = true
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.isHidden = true
        return field
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        return button
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Finish", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.isHidden = true
        return button
    }()

    
    lazy var passwordError: UILabel = {
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
        setupViews()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    // MARK: - UI SETUP
    func setupViews() {
        backgroundColor = .white
        addSubview(lockImage)
        addSubview(passwordLabel)
        addSubview(passwordReq)
        addSubview(nextButton)
        addSubview(finishButton)
        addSubview(passwordField)
        addSubview(passwordConfirmField)
        addSubview(passwordError)
    }
    
    func setupConstraints() {
        lockImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
        }

        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(228)
            make.bottom.equalToSuperview().inset(565)
            make.centerX.equalToSuperview()
        }

        passwordReq.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).inset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(497)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }

        finishButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(497)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }

        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordReq.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(95.5)
            make.trailing.equalToSuperview().inset(95.5)
            make.height.equalTo(25)
        }

        passwordConfirmField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(95.5)
            make.trailing.equalToSuperview().inset(95.5)
            make.height.equalTo(25)
        }

        passwordError.snp.makeConstraints { make in
            make.top.equalTo(passwordConfirmField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
