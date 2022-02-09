//
//  SceneDelegate.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.windowScene = windowScene

    let calendarViewController = CalendarViewController()
    let navigationController = UINavigationController(rootViewController: calendarViewController)
    window!.rootViewController = navigationController
    window?.makeKeyAndVisible()
    print("scene delegate")
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
