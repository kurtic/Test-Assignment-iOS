//
//  AppCoordinator.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    var useCases: UseCases
    
    // MARK: - Properties
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Private Properties
    private lazy var navigationController = UINavigationController()
    
    // MARK: - Life Cycle
    init(useCases: UseCases) {
        self.useCases = useCases
    }
    
    func start() {
        navigationController.viewControllers = [MainFactory.main.makeMainVC(coordinator: self)]
        configureNavigationBar()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func stop() {}
    
    private func configureNavigationBar() {
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController.navigationBar.standardAppearance = navigationBarAppearance
            navigationController.navigationBar.compactAppearance = navigationBarAppearance
        }
    }
}

// MARK: - MainVMDelegate
extension AppCoordinator: MainVMDelegate {
    func showDetailCard(for card: Card) {
        let detailsVC = MainFactory.main.makeCardDetailVC(coordinator: self, card: card)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
