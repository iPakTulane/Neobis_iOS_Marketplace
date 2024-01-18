//
//  OTPView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class OTPView: UIView {
    
    // MARK: - UI COMPONENTS
    lazy var userView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorBlue
        view.layer.cornerRadius = 20
        
        view.layer.shadowColor = UIColor.colorBlue.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        
        return view
    }()

    lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user 1")
        
        return image
    }()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the SMS code"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "We'll be throwing \na confirmation code via SMS"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor.colorGrey
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var codeField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 28)
        field.placeholder = "0 0 0 0"
        field.textAlignment = .center
        field.keyboardType = .numberPad
        
        return field
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "This number was already registered"
        label.textColor = UIColor.сolorRed
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    // MARK: - ACTION BUTTONS
    lazy var newCodeButton: UIButton = {
        let button = UIButton()
        //        button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Send a new code", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        return button
    }()

    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        codeField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        codeField.addTarget(self, action: #selector(numberFieldDidChange(_:)), for: .editingChanged)
        setupViews()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - UI SETUP
    func setupViews() {
        addSubview(userView)
        addSubview(userImage)
        addSubview(mainLabel)
        addSubview(descriptionLabel)
        addSubview(codeField)
        addSubview(newCodeButton)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.bottom.equalToSuperview().inset(612)
            make.leading.equalToSuperview().inset(147.5)
            make.trailing.equalToSuperview().inset(147.5)
        }

        userImage.snp.makeConstraints { make in
            make.center.equalTo(userView.snp.center)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(232)
            make.bottom.equalToSuperview().inset(561)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(263)
            make.bottom.equalToSuperview().inset(511)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        codeField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(334)
            make.bottom.equalToSuperview().inset(444)
            make.leading.equalToSuperview().inset(62)
            make.trailing.equalToSuperview().inset(62)
        }

        newCodeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(497)
            make.bottom.equalToSuperview().inset(271)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(384)
            make.leading.equalToSuperview().inset(34)
            make.trailing.equalToSuperview().inset(34)
            make.bottom.equalToSuperview().inset(406)
        }
    }

}

// MARK: - EXTENSION
extension OTPView: UITextFieldDelegate {
    
    @objc private func numberFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 4 {
            newCodeButton.backgroundColor = UIColor.colorBlue
        } else {
            newCodeButton.backgroundColor = UIColor.colorGrey
        }
    }
}
