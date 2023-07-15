//
//  AppDelegate.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var appCoordinator = AppCoordinator(useCases: CardsService())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = appCoordinator.window
        appCoordinator.start()
        return true
    }
}

