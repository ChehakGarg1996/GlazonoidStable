//
//  CatalogCell.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

struct CatalogViewModel {
    let name: String
    let shape: String
    let imageUrl: String
    var likes: Int
    let about: String
    let zone: String
    
    var isExpanded: Bool
    var isBookMarked: Bool
    var isLiked: Bool
    
    let didSelectBookmark: (() -> Void)?
    let didSelectShowMore: (() -> Void)?
    let didLikeClosure: (() -> Void)?
    let didShareWhatsapp: (() -> Void)?
    
    mutating func didExpand() {
        isExpanded = !isExpanded
    }
    
    mutating func didBookMark() {
        isBookMarked = !isBookMarked
    }
    
    mutating func didLike() {
        likes = likes + 1
        // to be sorted
//        likes += 1
//        isLiked
    }
    
    mutating func didShare() {
       
    }
}


class CatalogCell: UICollectionViewCell {

  
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    var shouldCellBeExpanded = Bool()
    var callBackAction: (() -> Void)?
    @IBOutlet weak var showMoreBtn: UIButton!
    
    
    var viewModel: CatalogViewModel? {
        didSet {
            lblDescription.text = viewModel?.about
            lblHeading.text = viewModel?.name
            likeCountLbl.text = "\(viewModel?.likes ?? 0) likes"
            btnSave.setImage(UIImage(systemName: viewModel?.isBookMarked ?? false ? "bookmark.fill" : "bookmark"), for: .normal)
            likeBtn.setImage(UIImage(systemName: viewModel?.isLiked ?? false ? "heart.fill" : "heart"), for: .normal)
            imageDisplay.sd_setImage(with: URL(string: viewModel?.imageUrl ?? ""), placeholderImage: UIImage(named: "default_placeholder"), options: [.allowInvalidSSLCertificates,.continueInBackground], context: nil)
        }
    }

    
    @IBAction func onClickBookmarkBtn(_ sender: UIButton) {
        viewModel?.didSelectBookmark?()
    }
    
    @IBAction func onClickShareBtn(_ sender: UIButton) {
        viewModel?.didShareWhatsapp?()
    }
    
    @IBAction func onClickShowMoreBtn(_ sender: UIButton) {
        viewModel?.didSelectShowMore?()
        
    }
    
    @IBAction func onClickLikeBtn(_ sender: UIButton) {
        viewModel?.didLikeClosure?()
    }
    
}
