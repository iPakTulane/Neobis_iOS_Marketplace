//
//  OTPView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class OTPView: UIView, UITextFieldDelegate {
    
    let userView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        view.layer.cornerRadius = 20 * UIScreen.main.bounds.height / 812
        
        view.layer.shadowColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        
        return view
    }()
    
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user 1")
        
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из СМС"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправим вам СМС с кодом подтверждения"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
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
        label.text = "Данный номер уже зарегистрирован"
        label.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    @objc let enterButton: UIButton = {
        let button = UIButton()
        //        button.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        button.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        button.layer.cornerRadius = 23 * UIScreen.main.bounds.height / 812
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        
        return button
    }()
    
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
    
    @objc private func numberFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 4 {
            enterButton.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        } else {
            enterButton.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
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
        userView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(120 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(612 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
        }
        
        userImage.snp.makeConstraints{ make in
            make.center.equalTo(userView.snp.center)
            make.height.equalTo(48 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(48 * UIScreen.main.bounds.width / 375)
        }
        
        mainLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(232 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(561 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(263 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(511 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        codeField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(334 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(444 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(62 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(62 * UIScreen.main.bounds.width / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(497 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(271 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        errorLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(384 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(34 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(34 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(406 * UIScreen.main.bounds.height / 812)
        }
    }
}
