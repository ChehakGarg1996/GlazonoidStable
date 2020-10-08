//
//  SignUpVC.swift
//  Glazonoid
//
//  Created by cubastion on 06/10/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { [self] authResult, error in
            
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                var user = firebase.auth().currentUser
                user.sendEmail
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.url = URL(string: "https://www.example.com")
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
              
                Auth.auth().sendSignInLink(toEmail:emailField.text ?? "no email found" ,
                                           actionCodeSettings: actionCodeSettings) { error in
                  // ...
                    if let error = error {
                    print(error)
                    }
                   
                    print("verified")
                    
                    UserDefaults.standard.set(emailField.text!, forKey: "Email")
                    let link = "glazonoidautomates.page.link"
                    if Auth.auth().isSignIn(withEmailLink: link) {

                        Auth.auth().signIn(withEmail: emailField.text! , link: link) { (user, error) in
                              // ...
                            }

                    }

                debugPrint(authResult!)
                let vc = HomeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }}
    }
}
}

