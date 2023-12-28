////
////  ChangeProductCoordinator.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 25/12/23.
////
//
//import Foundation
//import UIKit
//
//
//class ChangeProductCoordinator: Coordinator {
//    
//    var childCoordinators: [Coordinator] = []
//    var tabBarController: CustomTabBarController
//    
//    init(tabBarController: CustomTabBarController) {
//        self.tabBarController = tabBarController
//    }
//    
////    var navigationController: UINavigationController
////    
////    init(navigationController: UINavigationController) {
////        self.navigationController = navigationController
////    }
//    
//    func start() {
//        let loginViewModel = LoginViewModel()
//        let loginViewController = LoginViewController(loginProtocol: loginViewModel)
//        loginViewController.coordinator = self // Set the coordinator
//        
//        navigationController.setViewControllers([loginViewController], animated: false)
//    }
//}
//
//extension ChangeProductCoordinator {
//
//    func showRegistrationScreen() {
//        let registrationCoordinator = RegistrationCoordinator(navigationController: navigationController)
//        registrationCoordinator.start()
//    }
//
//    func showProfileScreen() {
//        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
//        profileCoordinator.start()
//    }
//    
//}
