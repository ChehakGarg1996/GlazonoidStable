//
//  AppDelegate.swift
//  fourthApp
//
//  Created by Ruchit on 09/07/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//
import GoogleSignIn
import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FirebaseFirestore

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate ,GIDSignInDelegate {
    
    
    var window: UIWindow?
    var imageView : UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: UIApplication.userDidTakeScreenshotNotification , object: <#T##Any?#>)
//
//        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    
//    func signin
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else{
//            let userId = user.userID
//            let authToken = user.authentication.idToken
            let user = User(
                userId: user.userID,
                authToken: user.authentication.idToken,
                name: user.profile.name,
                email: user.profile.email,
                image: signIn.currentUser.profile.imageURL(withDimension: 120))
            
            UserHandler.save(user)
            
        }
        guard let authentication = user.authentication else { return }
        
        let credentionals = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credentionals) { (authResult, error) in
            if let error = error {
                
                print ("Firebase sign In error")
                print(error)
                return
            }
            print("User signed in with firebase")
            NotificationCenter.default.post(
                name: Notification.Name("SuccessfulSignInNotification"), object: nil, userInfo: nil)
            //self.login()
            
        }
        
    }
    

    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                
                print ("Firebase sign In error")
                print(error)
                return
            }
            print("User signed in with firebase")
            NotificationCenter.default.post(
                name: Notification.Name("SuccessfulSignInNotification"), object: nil, userInfo: nil)
            
            // ...
        }
        
        
        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
            // ...
        }
        
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            
            return GIDSignIn.sharedInstance().handle(url) || ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        
        
        // MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }
        
        
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        imageView = UIImageView.init(image: UIImage.init(named:"blackscreen"))
        self.window?.addSubview(imageView!)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if imageView != nil{
        imageView?.removeFromSuperview()
    }
    
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        return
    }

}
