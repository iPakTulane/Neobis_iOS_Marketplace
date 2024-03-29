//
//  AddProductView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class AddProductView: UIView {
    
    var textHeightOne: Int = 40
    var textHeightTwo: Int = 40
    
    var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI COMPONENTS
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        // TODO:
        button.layer.cornerRadius = 12 //*1 - Assuming 1 is the original height value
        
        return button
    }()

    
    lazy var addImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "addProduct")
        
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        
        return collectionView
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "screenshot")
        
        return image
    }()
    
    lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Add \npicture"
        label.textColor = UIColor.colorBlue
        label.font = UIFont(name: "GothamPro-Medium", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var priceField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        // TODO:
        field.layer.cornerRadius = 12 //*1 - Assuming 1 is the original height value
        field.font = UIFont(name: "GothamPro", size: 16)
        field.placeholder = "Price"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()

    
    lazy var nameField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        // TODO:
        field.layer.cornerRadius = 12 //*1 - Assuming 1 is the original height value
        field.font = UIFont(name: "GothamPro", size: 16)
        field.placeholder = "Title"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()

    
    lazy var descriptionOne: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        // TODO:
        textView.layer.cornerRadius = 12
        textView.font = UIFont(name: "GothamPro", size: 16)
        // TODO:
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 10
        
        return textView
    }()
    
    lazy var descriptionTwo: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        // TODO:
        textView.layer.cornerRadius = 12
        textView.font = UIFont(name: "GothamPro", size: 16)
        // TODO:
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addDelegates()
        setupViews()
        setupConstraints()
    }
    

    func addDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        descriptionOne.delegate = self
        descriptionTwo.delegate = self
    }
    
    func addImage(_ image: UIImage) {
        images.append(image)
    }
    
    func setupViews() {
        backgroundColor = UIColor.colorBackground
        addSubview(addButton)
        addSubview(addImage)
        addSubview(collectionView)
        addSubview(addLabel)
        addSubview(priceField)
        addSubview(nameField)
        addSubview(descriptionOne)
        addSubview(descriptionTwo)
    }
    
    func setupConstraints() {
        
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(112)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(96)
            make.width.equalTo(76)
        }
        
        addImage.snp.makeConstraints { make in
            make.top.equalTo(addButton).inset(22)
            make.centerX.equalTo(addButton.snp.centerX)
            make.width.height.equalTo(27)
        }
        
        addLabel.snp.makeConstraints { make in
            make.top.equalTo(addButton).inset(52)
            make.leading.equalTo(addButton).inset(4)
            make.trailing.equalTo(addButton).inset(4)
            make.bottom.equalTo(addButton).inset(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.top)
            make.bottom.equalTo(addButton.snp.bottom)
            make.leading.equalTo(addButton.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(20)
        }
        
        priceField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(250)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        nameField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        descriptionOne.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        descriptionTwo.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionOne.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }

}

// MARK: - EXTENSION
extension AddProductView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 76
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            images.append(pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! CustomCell
        
        if indexPath.item < images.count {
            let image = images[indexPath.item]
            cell.imageView.image = image
        } else {
            cell.imageView.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text else {
            return true
        }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let numberOfLines = newText.components(separatedBy: CharacterSet.newlines).count
        
        let maxLines = 10
        
        if text == "\n" {
            textView.text.append("\n")
            
            if textView == descriptionOne {
                textHeightOne += 15
                print(textHeightOne)
            } else if textView == descriptionTwo {
                textHeightTwo += 15
            }
            
            updateConstraints()
            return false
        }
        
        if numberOfLines <= maxLines {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            if textView == descriptionOne {
                textHeightOne -= deletedNewlineCount * 15
                print(textHeightOne)
            } else if textView == descriptionTwo {
                textHeightTwo -= deletedNewlineCount * 15
            }
            
            updateConstraints()
            return true
        } else if text.isEmpty && numberOfLines == maxLines + 1 {
            let deletedNewlineCount = currentText.countOccurences(of: "\n", in: range)
            
            if textView == descriptionOne {
                textHeightOne -= deletedNewlineCount * 15
                print(textHeightOne)
            } else if textView == descriptionTwo {
                textHeightTwo -= deletedNewlineCount * 15
            }
            
            updateConstraints()
            return true
        }
        return false
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView == descriptionOne {
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textHeightOne = Int(newSize.height)
            print(textHeightOne)
            updateConstraints()
        } else if textView == descriptionTwo {
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textHeightTwo = Int(newSize.height)
            updateConstraints()
        }
    }
    
}
