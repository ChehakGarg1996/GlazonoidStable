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
    

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    
    @IBOutlet weak var InfoBtn: UIButton!
    @IBOutlet weak var popUPview: UIView!
    @IBOutlet weak var blackOverlayView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(popUPview)
        self.popUPview.isHidden = false
        self.overlayImage.alpha = 0
        self.progressView.isHidden = true
        self.VwInfo.layer.cornerRadius = VwInfo.frame.height/2
        self.VwEffect.layer.cornerRadius = VwEffect.frame.height/2
        blackOverlayView.isHidden = true

        self.setButtonBorder(button: btn1)
        self.setButtonBorder(button: btn2)
        self.setButtonBorder(button: btn3)
        self.setButtonBorder(button: btn4)
        self.setButtonBorder(button: btn5)
       

    }

    func setButtonBorder(button : UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func onClickSingleColorBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        blackOverlayView.isHidden = true

        InfoBtn.setTitle("Single Color", for: .normal)
        self.VwEffect.isHidden = false


    }
    
  
    @IBAction func onClickDoubleColorBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        blackOverlayView.isHidden = true
        InfoBtn.setTitle("Double Color", for: .normal)
        self.VwEffect.isHidden = true



    }
   
     @IBAction func onClickTripleTouchBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        blackOverlayView.isHidden = true

        InfoBtn.setTitle("Triple Color", for: .normal)
        self.VwEffect.isHidden = true



     }
 
   
    @IBAction func onClickDimmingBtn(_ sender: UIButton) {
        self.popUPview.isHidden = true
        blackOverlayView.isHidden = true

        self.progressView.isHidden = false
        InfoBtn.setTitle("Dimming", for: .normal)
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
        blackOverlayView.isHidden = true

        self.progressView.isHidden = false
        InfoBtn.setTitle("Transition", for: .normal)
        self.VwEffect.isHidden = true
        UIView.animate(withDuration: 4.0) {
            self.progressView.setProgress(1.0, animated: true)
            self.overlayImage.isHidden = false
            self.imageView.alpha = 0
            self.overlayImage.alpha = 1
           
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.popUPview.isHidden = true
        blackOverlayView.isHidden = true

    }
    
    @IBAction func popUpPresentBtn(_ sender: UIButton) {
        reset()
        self.popUPview.isHidden = false
        blackOverlayView.isHidden = false

    }
    
    func reset(){
        overlayImage.alpha = 0;
        imageView.alpha = 1;
        self.VwEffect.isHidden = true
        self.progressView.isHidden = true
        self.progressView.setProgress(0, animated: false)
        
    }
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
