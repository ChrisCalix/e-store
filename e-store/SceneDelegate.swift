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
        let item = FeedProduct( id: "110579",
                                url: "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                name: "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
                               current_value: "$0.75 Cash Back")
        
        let viewModel = ProductListViewModel()
       
        let navController = UINavigationController(rootViewController: ProductsListViewController(viewModel: viewModel))
        window.rootViewController = navController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

