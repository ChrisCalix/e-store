//
//  SceneDelegate.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewModel = ProductListViewModel()
        let vc = ProductsListViewController()
        vc.viewModel =  viewModel
        vc.view.layoutIfNeeded()
        let navController = UINavigationController(rootViewController: vc)
        window.rootViewController = navController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

