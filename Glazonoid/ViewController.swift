//
//  ViewController.swift
//  fourthApp
//
//  Created by Ruchit on 09/07/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate  {
    @IBOutlet weak var facebookButttonOutlet: UIButton!
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged out")
        
    }
    
    
    
    
    var  tempVal = 0
    
    
    @IBAction func customFacebookButton(_ sender: UIButton) {
        
        
        let Loginmanager = LoginManager()
        Loginmanager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in    if let error = error {
            print("Failed to login: \(error.localizedDescription)")
            return
            }
            guard let accessToken = AccessToken.current
                else {
                    print("Failed to get access token")
                    return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)    // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let VC = HomeVC()
                self.navigationController?.pushViewController(VC, animated: true)
                //            self.performSegue(withIdentifier: "defaultHomeScreenSeg", sender: self)
                
                // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
            }
        }
        
        
        
    }
    @IBAction func customGoogleLogin(_ sender: UIButton) {
        NotificationCenter.default.post(
            name: Notification.Name("GoogleLoginInitiated"), object: nil, userInfo: nil)
        GIDSignIn.sharedInstance()?.signIn()
        
        // signInButton.sendActions(for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("started")
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        //loginButton.center = view.center
        //view.addSubview(loginButton)
        //loginButton.sendActions(for: .touchUpInside)
        //loginButton.permissions = ["public_profile", "email"]
        if let token = AccessToken.current,
            !token.isExpired {
            let VC = HomeVC()
            self.navigationController?.pushViewController(VC, animated: true)
            // User is logged in, do work such as go to next view controller.
            //            performSegue(withIdentifier: "defaultHomeScreenSeg", sender: self)
            //tempVal = 1
            
            
        }
        
        //GIDSignIn.sharedInstance()?.currentUser
        if Auth.auth().currentUser != nil {
            
            print("Already signed in")
            tempVal = 1
            
        }else {
            print("Signing in")
            //  GIDSignIn.sharedInstance()?.presentingViewController = self
            //        GIDSignIn.sharedInstance().signIn()
            //GIDSignIn.sharedInstance()?.signIn()
            
            //   GIDSignIn.sharedInstance()?.presentingViewController = self
            //
        }
        
        
        print("ruchitDutt")
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        //  GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if tempVal == 1{
            let VC = HomeVC()
            self.navigationController?.pushViewController(VC, animated: false)
            //            performSegue(withIdentifier: "defaultHomeScreenSeg", sender: self)
            
        }
        
    }
    
    @objc func didSignIn()  {
        let VC = HomeVC()
        self.navigationController?.pushViewController(VC, animated: true)
        
        //        performSegue(withIdentifier: "defaultHomeScreenSeg", sender: self)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

