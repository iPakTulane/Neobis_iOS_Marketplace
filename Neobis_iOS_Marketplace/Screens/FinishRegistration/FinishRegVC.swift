//
//  FinishRegVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 28/12/23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class FinishRegViewController: UIViewController {
    
    let mainView = FinishRegView()
    var firstName: String = ""
    var nickName: String = ""
    var email: String = ""
    var lastName: String = ""
    var birthday: String = ""
    var phoneNumber: String = ""
    var getUserProtocol: GetUserProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(getUserProtocol: GetUserProtocol!) {
        self.getUserProtocol = getUserProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        addTargets()
        getUserData()
    }

    
    func setupNavigationView() {
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let finishButton = UIBarButtonItem(image: UIImage(named: "finish")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(finishPressed))
        self.navigationItem.rightBarButtonItem = finishButton
    }
    
    func addTargets() {
        mainView.setPicButton.addTarget(self, action: #selector(setPic), for: .touchUpInside)
        mainView.numberButton.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
    }
    
    
    func getUserData() {
        getUserProtocol.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userData):
                self?.parseUserData(userData)
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }

    func parseUserData(_ userData: [String: Any]) {
        
        if let photoURLString = userData["photo"] as? String,
           let photoURL = URL(string: "https://aibek-backender.org.kg/" + photoURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: photoURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.mainView.profilePic.image = image
                    }
                } else {
                    print("Failed to load image from URL:", photoURL)
                }
            }

        }
        
        if let firstName = userData["first_name"] as? String {
            self.firstName = firstName
            DispatchQueue.main.async {
                self.mainView.nameField.text = firstName
            }
        }
        
        if let username = userData["username"] as? String {
            self.nickName = username
            DispatchQueue.main.async {
                self.mainView.nickNameField.text = username
            }
        }
        
        if let email = userData["email"] as? String {
            self.email = email
            DispatchQueue.main.async {
                self.mainView.emailField.text = email
            }
        }
        
        if let lastName = userData["last_name"] as? String {
            self.lastName = lastName
            DispatchQueue.main.async {
                self.mainView.lastNameField.text = lastName
            }
        }
        
        if let birthday = userData["birthday"] as? String {
            self.birthday = birthday
            DispatchQueue.main.async {
                self.mainView.birthdayField.text = birthday
            }
        }
        
        if let phoneNumber = userData["phone_number"] as? String {
            self.phoneNumber = phoneNumber
            DispatchQueue.main.async {
                self.mainView.numberLabel.text = phoneNumber
                self.mainView.numberLabel.textColor = .black
                self.mainView.numberButton.setTitle("Update number", for: .normal)
            }
        }
    }
    
    @objc func numberPressed() {
        guard let first_name = mainView.nameField.text else { return }
        guard let last_name = mainView.lastNameField.text else { return }
        guard let birthday = mainView.birthdayField.text else { return }
        guard let image = mainView.profilePic.image else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = NumberViewController(numberProtocol: NumberViewModel(
            first_name: first_name,
            last_name: last_name,
            birthday: birthday,
            photo: imageData
        ))
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
    @objc func setPic() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func finishPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - EXTENSION
extension FinishRegViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            mainView.profilePic.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
