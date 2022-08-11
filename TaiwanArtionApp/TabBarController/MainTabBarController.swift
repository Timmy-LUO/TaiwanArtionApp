//
//  MainTabBarController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SideMenu

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    // MARK: - SetupTabBar
    private func setupTabBarController() {
        self.tabBar.backgroundColor = .backgroundColor
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .brown
        
        let findVC = FindExhibitionViewController(viewModel: FindExhibitionViewModel())
        let findController = UINavigationController(rootViewController: findVC)
        findController.tabBarItem.image = UIImage(named: "Find")
        findController.tabBarItem.title = "早找展覽"
        
        let nearbyVC = NearbyExhibitionViewController()
        let nearbyController = UINavigationController(rootViewController: nearbyVC)
        nearbyController.tabBarItem.image = UIImage(named: "Map")
        nearbyController.tabBarItem.title = "附近展覽"
        
        let shareVC = ShareExhibitionViewController()
        let shareController = UINavigationController(rootViewController: shareVC)
        shareController.tabBarItem.image = UIImage(named: "Share")
        shareController.tabBarItem.title = "分享展覽"
        
        viewControllers = [findController, nearbyController, shareController]
    }
}

