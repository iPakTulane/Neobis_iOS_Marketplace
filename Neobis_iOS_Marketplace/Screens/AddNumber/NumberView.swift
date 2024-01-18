//
//  NumberView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class NumberView: UIView {
    
    // MARK: - UI COMPONENTS
    lazy var phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorBlue
        view.layer.cornerRadius = 20
        
        view.layer.shadowColor = UIColor.colorBlue.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        // TODO:
        view.layer.shadowRadius = 4
        
        return view
    }()


    lazy var phoneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "call")
        
        return image
    }()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your phone number"
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
    
    lazy var numberField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 28)
        field.placeholder = "0(000) 000 000"
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
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
    //    button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        numberField.addTarget(self, action: #selector(numberFieldDidChange(_:)), for: .editingChanged)
        setupViews()
        setupConstraints()
    }
    
    
    // MARK: - UI SETUP
    func setupViews() {
        addSubview(phoneView)
        addSubview(phoneImage)
        addSubview(mainLabel)
        addSubview(descriptionLabel)
        addSubview(numberField)
        addSubview(enterButton)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        phoneView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.bottom.equalToSuperview().inset(612)
            make.leading.equalToSuperview().inset(147.5)
            make.trailing.equalToSuperview().inset(147.5)
        }

        phoneImage.snp.makeConstraints { make in
            make.center.equalTo(phoneView.snp.center)
            make.height.equalTo(36)
            make.width.equalTo(36)
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

        numberField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(334)
            make.bottom.equalToSuperview().inset(444)
            make.leading.equalToSuperview().inset(62)
            make.trailing.equalToSuperview().inset(62)
        }

        enterButton.snp.makeConstraints { make in
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
extension NumberView: UITextFieldDelegate {
    
    @objc private func numberFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 14 {
            enterButton.backgroundColor = UIColor.colorBlue
        } else {
            enterButton.backgroundColor = UIColor.colorGrey
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "X(XXX) XXX XXX", phone: newString)
        return false
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}

