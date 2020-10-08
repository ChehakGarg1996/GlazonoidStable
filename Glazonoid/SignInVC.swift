//
//  SignInVC.swift
//  Glazonoid
//
//  Created by cubastion on 06/10/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func onClickForgotPassBtn(_ sender: UIButton) {
        
    let vc = ResetPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onClickLoginBtn(_ sender: Any) {
        
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
            
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                
                debugPrint(authResult!)
                let vc = HomeVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }}
    }
        }


