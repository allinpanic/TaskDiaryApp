//
//  SceneDelegate.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit
import RealmSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.windowScene = windowScene
//    guard let realm = try? Realm() else {fatalError()}

    var config = Realm.Configuration()
    config.deleteRealmIfMigrationNeeded = true
    Realm.Configuration.defaultConfiguration = config

    let calendarViewController = CalendarViewController()
    let calendarModel = CalendarModel()
    calendarViewController.calendarModel = calendarModel
    let navigationController = UINavigationController(rootViewController: calendarViewController)
    window!.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  func sceneWillResignActive(_ scene: UIScene) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
  }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
