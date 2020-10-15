//
//  HomeCell.swift
//  Glazonoid
//
//  Created by cubastion on 11/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Lottie
class HomeCell: UICollectionViewCell , UICollectionViewDataSource , UICollectionViewDelegate {
    
    @IBOutlet weak var innerClcView: UICollectionView!
    //    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewMOreBtn: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var backAnimationV: AnimationView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var viewMore: UIImageView!
    
    @IBOutlet weak var screenNumberView: UIImageView!
    let VC = InnerCell()
    let VCC = HomeVC()
    var array1  = [String]()
    var array2 = [String]()
    var array3 = [String]()
    var indexMain : Int?
    var heading: String? // make ib outrlet
    var callBackAction: ((_ indexMain: Int) -> Void)?
    var callBackAction1: ((_ indexMain: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerClcView .register(UINib (nibName: "InnerCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        
        innerClcView.delegate = self
        innerClcView.dataSource = self
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        backAnimationV.loopMode = .loop
        backAnimationV.animationSpeed = 0.5
        backAnimationV.play()
        array1 = [ "catalog1" , "catalog2" ,"catalog3"]
        array2 = ["tech1" , "tech2" ,"tech3"]
        array3 = ["remote1" , "remote2"]
        backAnimationV.isHidden = true
//        headingLbl.numberOfLines = 0
//        self.backgroundColor = UIColor.init()
        
    }
    
    func setInnerCellData(indexpathSection:Int)
    {
        indexMain = indexpathSection
        innerClcView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if indexMain == 2{
            return 2
        }
        else {
        return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  self.innerClcView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InnerCell

        cell.viewMorebtn.isHidden = true
        cell.addMorebtn.isHidden = true

        //catalog cell
        if indexMain == 0
        {
            cell.imgVIew.image = UIImage(named:array1[indexPath.row])
            headingLbl.text = "Catalog"
            backAnimationV.isHidden = true
            self.screenNumberView.image = UIImage(named: "zero_one")
            if indexPath.row == 2 {
                cell.viewMorebtn.isHidden = false
            }
            cell.callBackAction = { [weak self] in
                self?.indexMain != nil ? self?.callBackAction?(self?.indexMain! ?? 0) : ()
            }
            return cell
        }
        
        //technology cell
        else if indexMain == 1
        {
            cell.imgVIew.image = UIImage(named:array2[indexPath.row])
            headingLbl.text = "Technology"
            backAnimationV.isHidden = false
            self.screenNumberView.image = UIImage(named: "zero_two")
            if indexPath.row == 2 {
                cell.viewMorebtn.isHidden = false
                       }
            cell.callBackAction = { [weak self] in
            self?.indexMain != nil ? self?.callBackAction?(self?.indexMain! ?? 0) : ()
            }
            
            return cell
            
        }
        
        // remote cell
        else if indexMain == 2
        {
            cell.imgVIew.image = UIImage(named:array3[indexPath.row])
            headingLbl.text = "Wifi Mirror Remote"
            headingLbl.numberOfLines = 2
            self.screenNumberView.image = UIImage(named: "zero_three")
            backAnimationV.isHidden = false
            animationView.isHidden = true
            if indexPath.row == 1{
                cell.viewMorebtn.isHidden = false
                cell.addMorebtn.isHidden = false
            }
            cell.callBackAction = { [weak self] in
            self?.indexMain != nil ? self?.callBackAction?(self?.indexMain! ?? 0) : ()
        }
            cell.callBackAction1 = { [weak self] in
            self?.indexMain != nil ? self?.callBackAction1?(self?.indexMain! ?? 0) : ()
        }
        return cell
    }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexMain == 2{
            innerClcView.scrollToItem(at:  IndexPath(item: 1, section: 0), at: .right, animated: true)

        }
        else{
            innerClcView.scrollToItem(at:  IndexPath(item: 2, section: 0), at: .right, animated: true)

        }

}
}

extension HomeCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // if remote , then increase height after 2 cell which incldes button
        if indexMain == 2{
            if indexPath.row > 0 {
            return CGSize(width: 260 + 60 + 10, height: self.innerClcView.frame.height);
        }
            // if catalog/technology , increase height after 3  cell which includes button
        }
        if indexPath.row > 1 {
            return CGSize(width: 260 + 60 + 10, height: self.innerClcView.frame.height);
        }
        return CGSize(width: 260, height: self.innerClcView.frame.height);
        
    }
    
    
    
}


