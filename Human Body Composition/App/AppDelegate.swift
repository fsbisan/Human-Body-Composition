//
//  AppDelegate.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let startVC = StartViewController()
        startVC.title = "РАЧЕТ"
       
        let measureListVC = UINavigationController(rootViewController: MeasureListViewController())
        measureListVC.title = "ИСТОРИЯ ИЗМЕРЕНИЯ"
        
        
        let aboutVC = UINavigationController(rootViewController: AboutViewController())
        aboutVC.title = "О ПРОГРАММЕ"
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.setViewControllers([startVC, measureListVC, aboutVC], animated: true)
        guard let items = tabBarVC.tabBar.items else { return false }
        
        let images = ["x.squareroot", "list.bullet.rectangle.portrait", "info.circle"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        window?.rootViewController = tabBarVC
        return true
    }
}

