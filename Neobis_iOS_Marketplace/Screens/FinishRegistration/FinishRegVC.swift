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
    var date_of_birth: String = ""
    var phoneNumber: String = ""
    var getUserProtocol: UserProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(getUserProtocol: UserProtocol!) {
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

    let apiService = APIService()
    // TODO:
    func parseUserData(_ userData: GetUserResponse) {
        if let avatarURLString = userData.avatar,
           let avatarURL = URL(string: apiService.baseURL + avatarURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: avatarURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.mainView.profilePic.image = image
                    }
                } else {
                    print("Failed to load FinishReg image from URL:", avatarURL)
                }
            }
        }
        
        if let firstName = userData.first_name {
            self.firstName = firstName
            DispatchQueue.main.async {
                self.mainView.nameField.text = firstName
            }
        }
        
        if let username = userData.username {
            self.nickName = username
            DispatchQueue.main.async {
                self.mainView.nickNameField.text = username
            }
        }
        
        if let email = userData.email {
            self.email = email
            DispatchQueue.main.async {
                self.mainView.emailField.text = email
            }
        }
        
        if let lastName = userData.last_name {
            self.lastName = lastName
            DispatchQueue.main.async {
                self.mainView.lastNameField.text = lastName
            }
        }
        
        // Note: The key 'birthday' does not exist in UserResponse, it should be 'date_of_birth'
        if let date_of_birth = userData.date_of_birth {
            self.date_of_birth = date_of_birth
            DispatchQueue.main.async {
                self.mainView.birthdayField.text = date_of_birth
            }
        }
        
        if let phoneNumber = userData.phone_number {
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
        guard let date_of_birth = mainView.birthdayField.text else { return }
        guard let image = mainView.profilePic.image else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
        let vc = NumberViewController(numberProtocol: NumberViewModel(
            first_name: first_name,
            last_name: last_name,
            date_of_birth: date_of_birth,
            avatar: imageData
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
