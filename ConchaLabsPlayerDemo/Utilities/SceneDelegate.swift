//
//  SceneDelegate.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let rootViewController = LoginViewController()
        // PlayerViewController(audioPlayer: CLAudioPlayer(), user: "Scott")
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: Fonts.nunitoSans, size: 22)!,
            NSAttributedString.Key.foregroundColor: Colors.darkGrey
            ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        window?.makeKeyAndVisible()
    }

}
