//
//  AppDelegate.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = SimulationFormViewController.instantiate()

        let navigation = UINavigationController(rootViewController: viewController)

        navigation.navigationBar.tintColor = UIColor.appGreen
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appGreen]
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}
