//
//  FinishRegView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 28/12/23.
//


import Foundation
import UIKit
import SnapKit

class FinishRegView: UIView, UITextFieldDelegate {
    
    var nickName: String = ""
    
    // MARK: - UI COMPONENTS
    let profilePic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultPic")
//        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()

    
    let setPicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose a photo", for: .normal)
        button.setTitleColor(UIColor.colorBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return button
    }()
    
    let firstSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.cornerRadius = 12
        
        return view
    }()

    
    let nameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "First name"
        
        return field
    }()
    
    let lastNameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "Last name"
        
        return field
    }()
    
    let nickNameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "Username"
//        field.text =
        
        return field
    }()
    
    let birthdayField: UITextField = {
        let field = UITextField()
        field.placeholder = "Date of birth"
        field.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return field
    }()

    let secondSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.cornerRadius = 12
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorBackground
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }()

    
    let numberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add number", for: .normal)
        button.setTitleColor(UIColor.colorBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return button
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.text = "0(000) 000 000"
        label.textColor = UIColor.colorGrey
        
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return field
    }()

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor.colorBackground
        
        nameField.delegate = self
        emailField.delegate = self
        birthdayField.delegate = self
        lastNameField.delegate = self
        nickNameField.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.endEditing(true)
//    }
    
    // MARK: - UI SETUP
    func setupViews() {
        addSubview(profilePic)
        addSubview(setPicButton)
        addSubview(firstSectionView)
        addSubview(secondSectionView)
        addSubview(nameField)
        addSubview(lastNameField)
        addSubview(nickNameField)
        addSubview(birthdayField)
        addSubview(numberButton)
        addSubview(numberLabel)
        addSubview(emailField)
    }
    
    func setupConstraints() {
        profilePic.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(112)
            make.bottom.equalToSuperview().inset(620)
            make.leading.equalToSuperview().inset(148)
            make.trailing.equalToSuperview().inset(148)
        }

        setPicButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(204)
            make.bottom.equalToSuperview().inset(584)
            make.leading.equalToSuperview().inset(98)
            make.trailing.equalToSuperview().inset(98)
        }

        firstSectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(252)
            make.bottom.equalToSuperview().inset(381)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        secondSectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(443)
            make.bottom.equalToSuperview().inset(280)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        nameField.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView.snp.top).inset(6)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(141)
        }

        lastNameField.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView.snp.top).inset(51)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(96)
        }

        nickNameField.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView.snp.top).inset(96)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(51)
        }

        birthdayField.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView.snp.top).inset(141)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(6)
        }

        numberButton.snp.makeConstraints { make in
            make.top.equalTo(secondSectionView.snp.top).inset(10)
            make.leading.equalTo(secondSectionView.snp.leading).inset(16)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(187)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(55)
        }

        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(secondSectionView.snp.top).inset(10)
            make.leading.equalTo(secondSectionView.snp.leading).inset(184)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(55)
        }

        emailField.snp.makeConstraints { make in
            make.top.equalTo(secondSectionView.snp.top).inset(55)
            make.leading.equalTo(secondSectionView.snp.leading).inset(16)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(16)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(10)
        }
    }

}
