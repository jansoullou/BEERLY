//
//  AppCoordinator.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        openRootViewController()
    }
    
    private func openRootViewController() {
        window?.rootViewController = MainPageConfigurator.build()
    }
}
