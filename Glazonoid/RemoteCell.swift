//
//  RemoteCell.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import VHProgressBar
class RemoteCell: UICollectionViewCell {

    @IBOutlet weak var progressBar: UIProgressView!
let verticalProgressBar = VerticalProgressBar()
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.progressBar.addSubview(verticalProgressBar)
//        verticalProgressBar.pgHeight = 200
//        verticalProgressBar.pgWidth = 45
        verticalProgressBar.frameBold = 0.5
        verticalProgressBar.frame = progressBar.frame
        verticalProgressBar.animateProgress(duration: 1.0, progressValue: 0.7)
        verticalProgressBar.startAnimation(type: "reverse", duration: 3.0)
        verticalProgressBar.stopAnimation()



    }

}
