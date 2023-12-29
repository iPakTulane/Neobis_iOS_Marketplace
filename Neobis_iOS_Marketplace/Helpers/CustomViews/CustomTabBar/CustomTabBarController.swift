//
//  CustomTabBarController.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 22/12/23.
//


import Foundation
import UIKit

class CustomTabBarController: UITabBarController {

    var nickName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        
        let customTabBar = CustomTabBar()
        customTabBar.tintColor = UIColor.colorBlue
        customTabBar.backgroundColor = .white
        self.setValue(customTabBar, forKey: "tabBar")

        let homeVC = UINavigationController(rootViewController: HomeViewController(getProduct: ProductViewModel()))
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: nil)

        let categoriesVC = UIViewController()
        categoriesVC.view.backgroundColor = .white
        categoriesVC.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(named: "wallet"), selectedImage: nil)

        let cartVC = UIViewController()
        cartVC.view.backgroundColor = .white
        cartVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "chat"), selectedImage: nil)

        let profileVC = UINavigationController(rootViewController: ProfileViewController(getUserProtocol: GetUserViewModel()))
        profileVC.view.backgroundColor = .white
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user"), selectedImage: nil)

        customTabBar.bigButton.addTarget(self, action: #selector(bigButtonPressed), for: .touchUpInside)

        viewControllers = [homeVC, categoriesVC, cartVC, profileVC]
    }

    @objc func bigButtonPressed() {
        let vc = AddProductViewController(addProductProtocol: AddProductViewModel())
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

}
