//
//  defaultHomeScreenController.swift
//  Glazonoid
//
//  Created by Ruchit on 15/07/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
class defaultHomeScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: UIButton) {
    
     let firebaseAuth = Auth.auth()
    do {
        
      try firebaseAuth.signOut()
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
        
        performSegue(withIdentifier: "loginScreenSeg", sender: self)
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
