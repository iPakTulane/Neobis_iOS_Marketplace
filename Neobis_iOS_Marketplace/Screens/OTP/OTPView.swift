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
    let userView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorBlue
        view.layer.cornerRadius = Screen.relativeHeight(20)
        
        view.layer.shadowColor = UIColor.colorBlue.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = Screen.relativeHeight(4)
        
        return view
    }()

    
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user 1")
        
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the SMS code"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "We'll be throwing \na confirmation code via SMS"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor.colorGrey
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let codeField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 28)
        field.placeholder = "0 0 0 0"
        field.textAlignment = .center
        field.keyboardType = .numberPad
        
        return field
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "This number was already registered"
        label.textColor = UIColor.сolorRed
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    // MARK: - ACTION BUTTONS
    let enterButton: UIButton = {
        let button = UIButton()
        //        button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = Screen.relativeHeight(23)
        button.setTitle("Next", for: .normal)
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
        addSubview(enterButton)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(120))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(612))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(147.5))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(147.5))
        }

        userImage.snp.makeConstraints { make in
            make.center.equalTo(userView.snp.center)
            make.height.equalTo(Screen.relativeHeight(48))
            make.width.equalTo(Screen.relativeWidth(48))
        }

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(232))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(561))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(263))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(511))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        codeField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(334))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(444))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(62))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(62))
        }

        enterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(497))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(271))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(384))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(34))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(34))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(406))
        }
    }

}

// MARK: - EXTENSION
extension OTPView: UITextFieldDelegate {
    
    @objc private func numberFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 4 {
            enterButton.backgroundColor = UIColor.colorBlue
        } else {
            enterButton.backgroundColor = UIColor.colorGrey
        }
    }
}
