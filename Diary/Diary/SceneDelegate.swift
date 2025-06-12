//
//  SceneDelegate.swift
//  Diary
//
//  Created by Дмитрий Забиякин on 30.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let authService = AuthService()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(routeVC(notification:)),
            name: Notification.Name("routeVC"),
            object: nil
        )
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        if authService.userLogin() {
            window?.rootViewController = UINavigationController(rootViewController: windowManager(vc: .home))

        } else {
            window?.rootViewController = windowManager(vc: .registr)
        }
        
        window?.makeKeyAndVisible()
    }
    
    private func windowManager(vc: WindowCase) -> UIViewController {
        switch vc {
        case .auth:
            return AuthViewController()
        case .registr:
            return RegistrViewController()
        case .home:
            return TabBarViewController()
        }
    }
    
    @objc func routeVC(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let vc = userInfo["vc"] as? WindowCase else { return }

        let newRoot: UIViewController
        switch vc {
        case .home:
            newRoot = UINavigationController(rootViewController: windowManager(vc: vc))
        default:
            newRoot = windowManager(vc: vc)
        }

        self.window?.rootViewController = newRoot
    }

    func sceneDidDisconnect(_ scene: UIScene) {    }

    func sceneDidBecomeActive(_ scene: UIScene) {    }

    func sceneWillResignActive(_ scene: UIScene) {    }

    func sceneWillEnterForeground(_ scene: UIScene) {    }

    func sceneDidEnterBackground(_ scene: UIScene) {    }


}

