//
//  ProfileVC.swift
//  Glazonoid
//
//  Created by cubastion on 21/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import FirebaseAuth


class ProfileVC: UIViewController {
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let user = UserHandler.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        userName.text = user?.name
        userEmail.text = user?.email
        let data = NSData(contentsOf:(user?.image)!) ?? nil
        if data != nil {
            profileImage.image = UIImage(data:data! as Data)
        }
        debugPrint(user)
    }
    
    @IBAction func onClickProductVideos(_ sender: UIButton) {
        
        let appURL = NSURL(string: "youtube://www.youtube.com/channel/UCkbXEo1cXRLmuU9ZVf_ne2Q")!
        let webURL = NSURL(string: "https://www.youtube.com/channel/UCkbXEo1cXRLmuU9ZVf_ne2Q")!
        
        if UIApplication.shared.canOpenURL(appURL as URL)
        {
            UIApplication.shared.open(appURL as URL)
        }
        else {
            // if Youtube app is not installed, open URL inside Safari
            UIApplication.shared.open(webURL as URL)
        }
        
    }
    @IBAction func onClickCallBAckBtn(_ sender: UIButton) {
        
        let VC = CallBackVC()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickWhatsappBtn(_ sender: UIButton) {
        //        "https://api.whatsapp.com/send?phone=" + "917838656865" + "&text=" + URLEncoder.encode("Hi, I would like to know more about your products.", "UTF-8"
        let whatsappURL = "whatsapp://send?phone=+917838656865&text=Hi I would like to know more about your products."
        if let urlString = whatsappURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func onClickInstagramBtn(_ sender: UIButton) {
        
        
        let appURL = NSURL(string: "instagram://instagram.com/glazonoidmirrors?igshid=15e5fddcy3zf4")!
        let webURL = NSURL(string: "https://instagram.com/glazonoidmirrors?igshid=15e5fddcy3zf4")!
        
        if UIApplication.shared.canOpenURL(appURL as URL)
        {
            UIApplication.shared.open(appURL as URL)
        }
        else {
            // if Youtube app is not installed, open URL inside Safari
            UIApplication.shared.open(webURL as URL)
        }
    }
    
    @IBAction func onClickFacebookBtn(_ sender: UIButton) {
        let facebookURL = NSURL(string: "fb://www.facebook.com/glazonoid")!
        if UIApplication.shared.canOpenURL(facebookURL as URL) {
            UIApplication.shared.open(facebookURL as URL)
        } else {
            UIApplication.shared.open(NSURL(string: "https://www.facebook.com/glazonoid")! as URL)
        }
    }
    
    @IBAction func onClickAddProductBtn(_ sender: UIButton) {
        
        let vc = AddProductVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func onClickSavedDesignsBtn(_ sender: UIButton) {
        
        let vc = CatalogVC()
        vc.status = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickLogOutBtn(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginScreen")
            navigationController?.pushViewController(ViewController(), animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    
    
}
