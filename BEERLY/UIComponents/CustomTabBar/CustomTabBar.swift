//
//  CustomTabBar.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//
import UIKit

class CustomTabBarController: UITabBarController {
        override func viewDidLoad() {
            super.viewDidLoad()
            tabBar.tintColor = .lightGray
            setupVC()
        }
        
        private func setupVC() {
            viewControllers = [
                createControllers(for: MainPageConfigurator.build(), image: UIImage(systemName: "house.circle")!),
                createControllers(for: CartConfigurator.build(), image: UIImage(systemName: "basket.fill")!),
                createControllers(for: ProfilePageConfigurator.build(), image: UIImage(systemName: "person.fill")!)
            ]
        }
        
        private func createControllers(
            for rootViewController: UIViewController,
            image: UIImage
        ) -> UIViewController {
            let navVC = UINavigationController(rootViewController: rootViewController)
            navVC.tabBarItem.image = image
            return navVC
        }
    }


