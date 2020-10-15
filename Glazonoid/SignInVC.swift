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
        
        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        
        
    }
    
    @IBAction func onClickForgotPassBtn(_ sender: UIButton) {
        
        let vc = ResetPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onClickLoginBtn(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil {
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
            
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                
                debugPrint(authResult!)
                let vc = HomeVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }}
        }
        
        else{
            
            let alertController = UIAlertController(title: "Login Error", message: "kindly fill all the fields", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


