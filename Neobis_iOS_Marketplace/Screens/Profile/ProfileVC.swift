//
//  ProfileVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
        
    var nickName: String = ""
    var image: UIImage?
    
    lazy var mainView = ProfileView()
    var mainViewModel: ProfileProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: ProfileProtocol!) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        checkFullRegistration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        addTargets()
        setupProfileData()
        checkFullRegistration()
    }

    func setupNavigationView() {
        title = "Profile"
        
        let changeButton = UIBarButtonItem(image: UIImage(named: "change")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeButtonPressed))
        self.navigationItem.rightBarButtonItem = changeButton
    }
    
    func addTargets() {
        mainView.finishRegButton.addTarget(self, action: #selector(finishRegButtonPressed), for: .touchUpInside)
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        mainView.productButton.addTarget(self, action: #selector(productButtonPressed), for: .touchUpInside)
    }
    
    func setupProfileData() {
        
        guard TokenManager.shared.accessToken != nil else {
            return
        }
        
        mainViewModel.getUserData() { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseUserData(data)
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }

    
    func parseUserData(_ userData: GetUserResponse) {
        
        if let username = userData.username {
            self.nickName = username
            DispatchQueue.main.async {
                self.mainView.nickLabel.text = username
            }
        }
                
        if let photoUrlString = userData.avatar,
            let imageUrl = URL(string: photoUrlString) {
            DispatchQueue.main.async {
                self.mainView.profilePic.af.setImage(withURL: imageUrl)
            }
        } else {
            print("Failed to load Profile image from URL:")
        }
        
        
        
        // Use the global base URL from APIService
//        let apiService = APIService()
//        if let avatarURLString = userData.avatar,
//           let avatarURL = URL(string: apiService.baseURL + avatarURLString) {
//            
//            DispatchQueue.global().async {
//                if let imageData = try? Data(contentsOf: avatarURL),
//                   let image = UIImage(data: imageData) {
//                    DispatchQueue.main.async {
//                        self.mainView.profilePic.image = image
//                    }
//                } else {
//                    print("Failed to load Profile image from URL:", avatarURL)
//                }
//            }
//            
//        }
        
    }

    func checkFullRegistration() {
        
        guard TokenManager.shared.accessToken != nil else {
            return
        }
        
        mainViewModel.updateUserData() { [weak self] result in
            switch result {
                
            case .success(let data):
                
                if let phoneNumber = data.phone_number {
                    print("Phone number:", phoneNumber)
                    
                    DispatchQueue.main.async {
                        self?.mainView.finishRegButton.isHidden = true
                    }
                }
            case .failure(let error):
                print("Failed to get profile user data:", error)
            }
        }
    }
    
    
    // MARK: - ACTION BUTTONS
    @objc func productButtonPressed() {
        
        let vc = ProductViewController(viewModel: ProductViewModel())
        
//        navigationController?.pushViewController(vc, animated: true)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc func finishRegButtonPressed() {
        let vc = PersonalDataViewController(viewModel: PersonalDataViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeButtonPressed() {
        let vc = PersonalDataViewController(viewModel: PersonalDataViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutButtonPressed() {
        
        // Clear the refresh token upon user's logout
        TokenManager.shared.refreshToken = nil
        
        // Clear the access token upon user's logout
        TokenManager.shared.accessToken = nil
        
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - EXTENSION
extension ProfileViewController: ProfileDelegate {    
    
    func didSucceed(withData data: GetUserResponse) {
//        // Check if the photo URL is valid
//        if let photoUrlString = data.first?.avatar,
//            let imageUrl = URL(string: photoUrlString) {
//            // Use AlamofireImage to asynchronously load and set the image
//            self.mainView.profilePic.af.setImage(withURL: imageUrl)
//        }
    }
    
    func didFail(withError error: Error) {
        print(error.localizedDescription)
    }
}
