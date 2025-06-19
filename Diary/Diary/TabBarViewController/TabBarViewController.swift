//
//  TabBarViewController.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 06.06.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupVC()
    }
    
    fileprivate func createNavController(viewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        
        viewController.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
    func setupVC() {
        viewControllers = [
            createNavController(
                viewController: MyTaskViewController(),
                title: "Мои задачи",
                image: UIImage(systemName: "person")!),
            createNavController(
                viewController: GeneralTaskViewController(),
                title: "Общие задачи",
                image: UIImage(systemName: "person.line.dotted.person")!),
            createNavController(
                viewController: SettingViewController(),
                title: "Настройки",
                image: UIImage(systemName: "gearshape")!)
        ]
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "BackgroundTabBar") // фон таббара

        // Цвет активных иконок
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "IconTabBar")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "IconTabBar") ?? .blue
        ]
        
        // Цвет неактивных иконок
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray

        tabBar.standardAppearance = appearance

        // Для iOS 15+, иначе будет прозрачным при скролле
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        tabBar.isTranslucent = false
    }
    
}
