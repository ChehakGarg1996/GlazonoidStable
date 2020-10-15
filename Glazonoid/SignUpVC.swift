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
    @IBOutlet weak var lblNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        lblNotification.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        
        if nameField.text != nil && emailField.text != nil && mobileField.text != nil && passwordField.text != nil  {
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { [self] authResult, error in
                
                
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    
                  
                    if let user = Auth.auth().currentUser {
                    for profile in user.providerData {
                        
                        let user1 = User(
                            userId: profile.uid,
                            authToken: profile.providerID ,
                            name: profile.displayName ?? "",
                            email: profile.email ?? "" ,
                            image: profile.photoURL ?? Data(contentsOf: URL(string: "user")),
                        
                        UserHandler.save(user1)
                        
                        if user.isEmailVerified == false {
                        user.sendEmailVerification { (error) in
                            
                            guard error != nil else {
                                Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.showLabel), userInfo: nil, repeats: false)
                                return print("user email verification sent")
                                
                            }
                        }
                    }
                  
                        
                        let vc = HomeVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    
                }
                    }
                }
            }
        }
        
        else{
            
            let alertController = UIAlertController(title: "Login Error", message:"kindly fill all the fields", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
    }
    
    @objc func showLabel(){
        self.lblNotification.isHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
