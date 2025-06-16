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
        view.backgroundColor = UIColor.systemBackground
        setupVC()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
//
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationItem.title = title
        return navController
    }
    
    func setupVC() {
        viewControllers = [
            createNavController(for: MyTaskViewController(), title: "Мои задачи", image: UIImage(systemName: "person")!),
            createNavController(for: GeneralTaskViewController(), title: "Общие задачи", image: UIImage(systemName: "person")!)
        ]
    }
    
}
