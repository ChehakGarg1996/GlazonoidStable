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
    @IBOutlet weak var btn: UIButton!
    var callBackAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVIew.layer.borderWidth = 10
        self.imgVIew.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    @IBAction func onClickViewMoreBTn(_ sender: UIButton) {
        callBackAction?()
       
    }

}
