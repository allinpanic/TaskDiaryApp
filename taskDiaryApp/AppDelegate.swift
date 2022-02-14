//
//  AppDelegate.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    var config = Realm.Configuration()
    config.deleteRealmIfMigrationNeeded = true
    Realm.Configuration.defaultConfiguration = config
    if #available(iOS 13, *) {
    } else {
      self.window = UIWindow()
//      guard let realm = try? Realm() else {fatalError()}
      let calendarViewController = CalendarViewController()
      let calendarModel = CalendarModel()
      calendarViewController.calendarModel = calendarModel
      let navigationController = UINavigationController(rootViewController: calendarViewController)
      self.window!.rootViewController = navigationController
      self.window!.makeKeyAndVisible()
    }

    return true
  }

  // MARK: UISceneSession Lifecycle

  @available(iOS 13.0, *)
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }

}
