//
//  CallBackVC.swift
//  Glazonoid
//
//  Created by cubastion on 22/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit

class CallBackVC: UIViewController {
    
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet var outputLblCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLblCollection.forEach { $0.text = "" }
        
    }
    
    
    
    
    // tap on digits to enter mobile number
    @IBAction func didTapDigitBtn(_ sender: UIButton) {
        
        guard let idx = outputLblCollection.firstIndex(where: {
            return $0.text == nil || $0.text == ""
        }) else { return }
        outputLblCollection[idx].text = "\(sender.tag)"
 
    }
    
    // delete wrong didit entered
    @IBAction func onClickDeleteDigitBtn(_ sender: UIButton) {
        guard let idx = outputLblCollection.lastIndex(where: {
         $0.text != nil && $0.text != ""
        }) else { return }
        outputLblCollection[idx].text = ""
        
    }
    
    // back to last controller
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

