////
////  Coordinator.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 25/12/23.
////
//
//import Foundation
//import UIKit
//
//protocol Coordinator: AnyObject {
//    var childCoordinators: [Coordinator] { get set }
//    var tabBarController: CustomTabBarController { get }
//    var navigationController: UINavigationController? { get }
//
//    func start()
//}
//
//extension Coordinator {
//    var navigationController: UINavigationController? {
//        return tabBarController.selectedViewController as? UINavigationController
//    }
//}
//
//
