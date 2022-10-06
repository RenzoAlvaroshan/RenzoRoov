//
//  MainTabBarController.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 05/10/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    // MARK: - Helpers

    func configureViewControllers() {
        view.backgroundColor = .white

        let vc1 = UINavigationController(rootViewController: MovieViewController(viewModel: MovieViewModel()))
        let vc2 = UINavigationController(rootViewController: MovieListViewController(viewModel: MovieViewModel()))

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")

        vc1.title = "Home"
        vc2.title = "List"

        tabBar.tintColor = .label

        setViewControllers([vc1, vc2], animated: true)
    }

}

