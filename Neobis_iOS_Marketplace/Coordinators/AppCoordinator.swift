////
////  AppCoordinator.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 25/12/23.
////
//
//
//import Foundation
//import UIKit
//
//class AppCoordinator: Coordinator {
//
//    let window: UIWindow?
//    var tabBarController: UITabBarController!
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
//    
//    func start() {
//        guard let window = window else {
//            return
//        }
//
//        // Create instances of your view controllers and coordinators
//
//        let loginCoordinator = LoginCoordinator(viewModel: LoginViewModelProtocol)
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [loginCoordinator.rootViewController]
//
//        tabBarController = UITabBarController()
//        tabBarController.viewControllers = [navigationController1, navigationController2]
//
//        window.rootViewController = tabBarController
//    }
//
//    func finish() {
//        // Any cleanup logic can go here
//    }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//class AppCoordinator: Coordinator {
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
//        // Initialize and start your main flow (login)
//        let nextCoordinator = LoginCoordinator(tabBarController: tabBarController)
//        nextCoordinator.start()
//    }
//}
//
//
//import UIKit
//
//class AppController {
//    var window: UIWindow?
//    var loginCoordinator: LoginCoordinator?
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
//
//    func start() {
//        // Create coordinators
//        loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
//
//        // Start coordinators
//        loginCoordinator?.start()
//
//        // Set the initial rootViewController (you can customize this based on your needs)
//        window?.rootViewController = loginCoordinator?.navigationController
//
//        // Make the window visible
//        window?.makeKeyAndVisible()
//    }
//
//}
