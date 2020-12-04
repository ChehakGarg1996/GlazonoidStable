//
//  RemoteVC.swift
//  Glazonoid
//
//  Created by cubastion on 30/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import LiveFader
import ChromaColorPicker

class RemoteVC: UIViewController {
    @IBOutlet weak var lblWarmWhite: UILabel!
    
    @IBOutlet weak var warmWhiteProgress: LiveFaderView!
    @IBOutlet weak var WhiteProgress: LiveFaderView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var VolumeProgress: LiveFaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setProgressBar(fader: WhiteProgress)
        setProgressBar(fader: warmWhiteProgress)
        WhiteProgress.faderEnabledForegroundColor = UIColor.white
        warmWhiteProgress.faderEnabledForegroundColor = UIColor.yellow
        VolumeProgress.faderEnabledForegroundColor = UIColor.red
        VolumeProgress.direction = .vertical
        VolumeProgress.style = .fromBottom
        let colorPicker = ChromaColorPicker(frame: CGRect(x: 40, y: 10, width: 150, height: 150))
        self.colorView.addSubview(colorPicker)
        let peachColor = UIColor(red: 1, green: 203 / 255, blue: 164 / 255, alpha: 1)
        colorPicker.addHandle(at: peachColor)

       
    }
    
    func setProgressBar(fader:LiveFaderView) {
        fader.direction = .vertical
        fader.style = .fromBottom
        fader.layer.cornerRadius = 10
        
    }

    @IBAction func onClickWarmWhiteValue(_ sender: LiveFaderView) {
        
        lblWarmWhite.text = ("\(Int(sender.value))")
    }
   
    @IBAction func onClickWhiteValue(_ sender: LiveFaderView) {
   
}
    @IBAction func onClickVolumeValue(_ sender: LiveFaderView) {
   
}
    
    @IBAction func onClickBACKBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
