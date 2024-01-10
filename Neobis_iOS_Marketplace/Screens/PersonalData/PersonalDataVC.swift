//
//  PersonalDataVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class PersonalDataViewController: UIViewController {
        
    let mainView = PersonalDataView()
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
        
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let finishButton = UIBarButtonItem(image: UIImage(named: "finish")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(finishPressed))
        self.navigationItem.rightBarButtonItem = finishButton
        
        mainView.setPicButton.addTarget(self, action: #selector(setPic), for: .touchUpInside)
        mainView.numberButton.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
        
        getUserData()
    }
    
//    func getUserData() {
//        getUserProtocol.fetchUserData() { [weak self] result in
//            switch result {
//            case .success(let userData):
//                self?.parseUserData(userData)
//            case .failure(let error):
//                print("Failed to fetch user data:", error)
//            }
//        }
//    }
    
    func getUserData() {
        getUserProtocol.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userResponse):
                // Convert UserResponse to [String: Any]
                let userData = [
                    "avatar": userResponse.avatar,
                    "username": userResponse.username,
                    "email": userResponse.email,
                    "first_name": userResponse.first_name,
                    "last_name": userResponse.last_name,
                    "date_of_birth": userResponse.date_of_birth,
                    "phone_number": userResponse.phone_number
                ].compactMapValues { $0 }
                self?.parseUserData(userData)
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }

    func parseUserData(_ userData: [String: Any]) {
        // TODO: 
        
        let apiService = APIService()
        
        if let photoURLString = userData["avatar"] as? String,
           let photoURL = URL(string: apiService.baseURL + photoURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: photoURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.mainView.profilePic.image = image
                    }
                } else {
                    print("Failed to load PersonalData image from URL:", photoURL)
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
        
        if let date_of_birth = userData["date_of_birth"] as? String {
            self.date_of_birth = date_of_birth
            DispatchQueue.main.async {
                self.mainView.birthdayField.text = date_of_birth
            }
        }
        
        if let phoneNumber = userData["phone_number"] as? String {
            self.phoneNumber = phoneNumber
            DispatchQueue.main.async {
                self.mainView.numberLabel.text = phoneNumber
                self.mainView.numberLabel.textColor = .black
                self.mainView.numberButton.setTitle("Change number", for: .normal)
            }
        }
    }
    
    
    // MARK: - ACTION BUTTONS
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
        vc.sourceType = .photoLibrary // .camera to capture a new photo
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
extension PersonalDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
