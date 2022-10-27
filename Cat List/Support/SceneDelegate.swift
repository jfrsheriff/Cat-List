//
//  SceneDelegate.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ScreenFactory.getRootViewController()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }

    
    private func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = UIHelper.appThemeColor
    }

}

