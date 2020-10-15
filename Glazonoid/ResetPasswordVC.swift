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
    @IBOutlet weak var lblNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNotification.isHidden = true

        
    }

    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) { error in
            
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.showLabel), userInfo: nil, repeats: false)
  
        }
        
       
        
        
    }
    
    @objc func showLabel(){
        self.lblNotification.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
