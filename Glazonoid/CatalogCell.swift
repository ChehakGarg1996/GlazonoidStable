//
//  CatalogCell.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase


class CatalogCell: UICollectionViewCell {

    @IBOutlet weak var imageDescription: UITextView!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var likeBtn: UIImageView!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCell()
    }

    func setUpCell() {
        
      var ref: DatabaseReference!

        ref = Database.database().reference()
        
        
        
    }
}
