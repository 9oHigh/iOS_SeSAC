//
//  SceneDelegate.swift
//  FirebaseProj
//
//  Created by 이경후 on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        //ATT Framework
        //씬이 액티브 상태가 되고나서 1초뒤에 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                      // 허용하지 않을 경우 analytics를 false로 주어야함.
                case .notDetermined:
                    print("결정이 되지 않았음")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .restricted:
                    print("거절 되었음")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .denied:
                    print("거절 되었음")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .authorized:
                    print("허용 되었음")
                    // 이 경우에만 애널리틱스를 적용할 수 있음
                    Analytics.setAnalyticsCollectionEnabled(true)
                @unknown default:
                    print("디폴트")
                    Analytics.setAnalyticsCollectionEnabled(false)
                }
            }
        }
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

