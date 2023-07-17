//
//  SceneDelegate.swift
//  CalculatorWithSB
//
//  Created by (^ㅗ^)7 iMac on 2023/07/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // SB없이 코드로 구현하기 위해 필수적으로 구현해야하는 코드
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        let rootViewController = MainViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

}

