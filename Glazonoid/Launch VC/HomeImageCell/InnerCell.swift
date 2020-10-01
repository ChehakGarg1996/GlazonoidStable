//
//  InnerCell.swift
//  Glazonoid
//
//  Created by cubastion on 11/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit

class InnerCell: UICollectionViewCell {
    @IBOutlet weak var imgVIew: UIImageView!
    @IBOutlet weak var viewMorebtn: UIButton!
    @IBOutlet weak var addMorebtn: UIButton!

    var callBackAction: (() -> Void)?
    var callBackAction1: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVIew.layer.borderWidth = 10
        self.imgVIew.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor

    }
    
    @IBAction func onClickViewMoreBTn(_ sender: UIButton) {
        callBackAction?()
       
    }

    @IBAction func onClickAddMoreBTn(_ sender: UIButton) {
        callBackAction1?()
       
    }
}
