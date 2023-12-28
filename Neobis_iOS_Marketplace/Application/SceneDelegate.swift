//
//  SceneDelegate.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 20/12/23.
//
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        // To start with Custom Tab Bar
        window?.rootViewController = CustomTabBarController()

        // To start with Login screen
//        let vc = LoginViewController(loginProtocol: LoginViewModel())
//        let vc = RegistrationViewController()
//        let vc = OTPViewController()
//        window?.rootViewController = UINavigationController(rootViewController: vc)
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

//import UIKit
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//        guard let _ = (scene as? UIWindowScene) else { return }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//    }
//
//
//}
