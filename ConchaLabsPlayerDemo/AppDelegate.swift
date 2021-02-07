//
//  AppDelegate.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit
import Firebase
import GoogleSignIn
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
       
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    private func setUpAudioSession() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: AVAudioSession.RouteSharingPolicy.longFormAudio)
        } catch {
            print("Failed to set audio session route sharing policy: \(error)")
        }
    }
//
//    @objc func handleRouteChange(notification: Notification) {
//        guard let userInfo = notification.userInfo,
//            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
//            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
//                return
//        }
//
//        // Switch over the route change reason.
//        switch reason {
//
//        case .newDeviceAvailable: // New device found.
//            let session = AVAudioSession.sharedInstance()
//            headphonesConnected = hasHeadphones(in: session.currentRoute)
//
//        case .oldDeviceUnavailable: // Old device removed.
//            if let previousRoute =
//                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
//                headphonesConnected = hasHeadphones(in: previousRoute)
//            }
//
//        default: ()
//        }
//    }
//
//    func hasHeadphones(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
//        // Filter the outputs to only those with a port type of headphones.
//        return !routeDescription.outputs.filter({$0.portType == .headphones}).isEmpty
//    }
}

