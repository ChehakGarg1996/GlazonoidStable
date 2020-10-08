//
//  ResetPasswordVC.swift
//  Glazonoid
//
//  Created by cubastion on 08/10/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) { error in
        
        }
        
        
    }
    

}
