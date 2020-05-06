//
//  SceneDelegate.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 27/2/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        checkLogin()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    
    func checkLogin() {
        
        
        let defaults = UserDefaults.standard
      //  let tokenSave = UserDefaults.standard
        
        if defaults.bool(forKey: "First Launch") == true  {
            
            //defaults.set(true, forKey: "First Launch")
            
             TokenUrl.shared.token = UserDefaults.standard.string(forKey: "saveToken") ?? ""
            TokenUrl.shared.username = UserDefaults.standard.string(forKey: "saveUsername") ?? ""
            TokenUrl.shared.password = UserDefaults.standard.string(forKey: "savePassword") ?? ""
            
            //                    tokenSave.set(signin.tt, forKey: "token save")
            //                    TokenUrl.shared.token = signin.tt
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let rootVC = storyboard.instantiateViewController(identifier: "TabController") as? TabController else {
                print("ViewController not found")
                return
            }
            
            let rootNC = UINavigationController(rootViewController: rootVC)
            self.window?.rootViewController = rootNC
            self.window?.makeKeyAndVisible()
            
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

