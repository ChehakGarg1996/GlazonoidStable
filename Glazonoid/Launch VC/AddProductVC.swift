//
//  AddProductVC.swift
//  Glazonoid
//
//  Created by cubastion on 01/10/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit

class AddProductVC: UIViewController {

    @IBOutlet weak var step1View: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        step1View.layer.cornerRadius = 20

      
    }

    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
