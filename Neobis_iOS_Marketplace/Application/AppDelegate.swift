//
//  AppDelegate.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 20/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //         Override point for customization after application launch.
        UIFont.familyNames.forEach({ name in
            for font_name in UIFont.fontNames(forFamilyName: name){
                print("\n\(font_name)")
            }
        })
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}




//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//    var appCoordinator: AppCoordinator!
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//
//        appCoordinator = AppCoordinator(window: window)
//        appCoordinator.start()
//
//        return true
//    }
//}



//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    
//    // MARK: Properties
//    var window: UIWindow?
//    var coordinator: Coordinator?
//    
//    // MARK: App lifecycle
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let customTabBarController = CustomTabBarController()
//        window?.rootViewController = customTabBarController
//        window?.makeKeyAndVisible()
//
//        // Initialize and start the app coordinator
//        coordinator = AppCoordinator(tabBarController: customTabBarController)
//        coordinator?.start()
//        return true
//    }
//    
//}

        
//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//    var appController: AppController?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        // Create the main window
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        // Initialize AppController with the window
//        appController = AppController(window: window)
//
//        // Start the AppController
//        appController?.start()
//
//        return true
//    }
//
//}





//    var window: UIWindow?
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        
//        guard let _ = (scene as? UIWindowScene) else { return }
//        guard let scene = (scene as? UIWindowScene) else { return }
//        
//        window = UIWindow(windowScene: scene)
//        window?.rootViewController = CustomTabBarController()

        //        window?.rootViewController = UINavigationController(rootViewController: LoginViewController(loginProtocol: LoginViewModel()))
        
//        window?.makeKeyAndVisible()
//    }
    
    
    
    

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//
//    }




