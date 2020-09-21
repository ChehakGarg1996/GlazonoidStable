//
//  TechnologyVC.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit

class TechnologyVC: UIViewController {

    @IBOutlet weak var switchEffect: UISwitch!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var overlayImage: UIImageView!
    @IBOutlet weak var VwInfo: UIView!
    @IBOutlet weak var VwEffect: UIView!
    
    @IBOutlet weak var InfoBtn: UIButton!
    @IBOutlet weak var popUPview: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(popUPview)
        self.popUPview.isHidden = false
        self.overlayImage.alpha = 0
        self.progressView.isHidden = true
        self.VwEffect.isHidden = true
//        self.overlayImage.isHidden = true

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickSingleColorBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        InfoBtn.titleLabel?.text =  "Single Color"
        self.VwEffect.isHidden = false


    }
    
  
    @IBAction func onClickDoubleColorBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        InfoBtn.titleLabel?.text =  "Double Color"
        self.VwEffect.isHidden = true



    }
   
     @IBAction func onClickTripleTouchBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        InfoBtn.titleLabel?.text =  "Triple Color"
        self.VwEffect.isHidden = true



     }
 
   
    @IBAction func onClickDimmingBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        self.progressView.isHidden = false
        InfoBtn.titleLabel?.text =  "Dimming"
        self.VwEffect.isHidden = false



        UIView.animate(withDuration: 4.0) {
                  self.progressView.setProgress(1.0, animated: true)
                  self.overlayImage.isHidden = false
                  self.imageView.alpha = 0
                  self.overlayImage.alpha = 1
                 
              }

    }
    
    @IBAction func onClickTransitionBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        self.progressView.isHidden = false
        InfoBtn.titleLabel?.text =  "Transition"
        self.VwEffect.isHidden = true



        UIView.animate(withDuration: 4.0) {
            self.progressView.setProgress(1.0, animated: true)
            self.overlayImage.isHidden = false
            self.imageView.alpha = 0
            self.overlayImage.alpha = 1
           
        }
        
    }
    
    @IBAction func popUpPresentBtn(_ sender: UIButton) {
        reset()
        self.popUPview.isHidden = false

    }
    
    func reset(){
        overlayImage.alpha = 0;
        imageView.alpha = 1;
        self.VwEffect.isHidden = true
        self.progressView.isHidden = true
        self.progressView.setProgress(0, animated: false)
        
    }
}
