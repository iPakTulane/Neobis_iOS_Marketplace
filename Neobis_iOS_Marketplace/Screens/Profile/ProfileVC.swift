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
        
    let mainView = ProfileView()
    var nickName: String = ""
    var image: UIImage?
    var mainViewModel: GetUserProtocol!
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(getUserProtocol: GetUserProtocol!) {
        self.mainViewModel = getUserProtocol
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
        checkFullRegister()
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
    
    func getUserData() {
        mainViewModel.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userData):
                self?.parseUserData(userData)
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
                
        let apiService = APIService()
        
        // Use the global base URL from APIService
        if let avatarURLString = userData.avatar,
           let avatarURL = URL(string: apiService.baseURL + avatarURLString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: avatarURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.mainView.profilePic.image = image
                    }
                } else {
                    print("Failed to load Profile image from URL:", avatarURL)
                }
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    func checkFullRegister() {
        guard let accessToken = TokenManager.shared.accessToken else {
            return
        }
        
        print(accessToken)
        
        mainViewModel.fetchUserData() { [weak self] result in
            switch result {
                
            case .success(let userData):
                
                if let phoneNumber = userData.phone_number {
                    print("Phone number:", phoneNumber)
                    
                    DispatchQueue.main.async {
                        self?.mainView.finishRegButton.isHidden = true
                    }
                }
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }
    
    
    // MARK: - ACTION BUTTONS
    @objc func productButtonPressed() {
        
        let vc = ProductViewController(product: ProductViewModel(), productProtocol: GetUserViewModel())
        
//        navigationController?.pushViewController(vc, animated: true)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc func finishRegButtonPressed() {
        let vc = PersonalDataViewController(getUserProtocol: GetUserViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeButtonPressed() {
        let vc = PersonalDataViewController(getUserProtocol: GetUserViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutButtonPressed() {
//        let vc = CustomTabBarController()
        
        // Clear the refresh token upon user's logout
        TokenManager.shared.refreshToken = nil
        
        // Clear the access token upon user's logout
        TokenManager.shared.accessToken = nil
        
        dismiss(animated: true, completion: nil)
    }
    
}
