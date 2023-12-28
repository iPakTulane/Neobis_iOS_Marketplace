////
////  RegistrationCoordinator.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 25/12/23.
////
//
//import Foundation
//import UIKit
//
//class RegistrationCoordinator: Coordinator {
//    
//    var childCoordinators: [Coordinator] = []
//    var tabBarController: CustomTabBarController
//    
//    init(tabBarController: CustomTabBarController) {
//        self.tabBarController = tabBarController
//    }
//    
//    func start() {
//        let registrationViewController = RegistrationViewController()
//        registrationViewController.coordinator = self // Set the coordinator
//        
//        navigationController.pushViewController(registrationViewController, animated: true)
//    }
//}
//
//extension RegistrationCoordinator {
//
//    func showPasswordScreen(userName: String, email: String) {
//        let passwordCoordinator = PasswordCoordinator(navigationController: navigationController, userName: userName, email: email)
//        passwordCoordinator.start()
//    }
//    
//}
