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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerClcView .register(UINib (nibName: "InnerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.innerClcView .register(UINib (nibName: "RemoteCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
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
        array3 = ["" , "" ,""]
        backAnimationV.isHidden = true
        
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
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  self.innerClcView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InnerCell
        let cell2 = self.innerClcView.dequeueReusableCell(withReuseIdentifier: "cell2" , for: indexPath) as! RemoteCell
        cell.btn.isHidden = true
        if indexMain == 0
        {
            cell.imgVIew.image = UIImage(named:array1[indexPath.row])
            headingLbl.text = "Catalog"
            backAnimationV.isHidden = true
            self.screenNumberView.image = UIImage(named: "zero_one")
            if indexPath.row == 2 {
                cell.btn.isHidden = false
            }
            cell.callBackAction = { [weak self] in
                self?.indexMain != nil ? self?.callBackAction?(self?.indexMain! ?? 0) : ()
            }
            return cell
        }
        else if indexMain == 1
        {
            cell.imgVIew.image = UIImage(named:array2[indexPath.row])
            headingLbl.text = "Technology"
            backAnimationV.isHidden = false
            self.screenNumberView.image = UIImage(named: "zero_two")
            if indexPath.row == 2 {
                cell.btn.isHidden = false
                       }
            cell.callBackAction = { [weak self] in
            self?.indexMain != nil ? self?.callBackAction?(self?.indexMain! ?? 0) : ()
            }
            
            return cell
            
        }
        else if indexMain == 2
        {
            cell.imgVIew.image = UIImage(named:array2[indexPath.row])
            headingLbl.text = "Wifi Mirror Remote"
            self.screenNumberView.image = UIImage(named: "zero_three")
            backAnimationV.isHidden = false
            animationView.isHidden = true
            return cell2
            
        }
        return cell
    }
}

extension HomeCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 3rd cell large size, with arrow
        // 1st and 2nd cell small size
        if indexPath.row > 1 {
            return CGSize(width: 260 + 60 + 10, height: self.innerClcView.frame.height);
        }
        return CGSize(width: 260, height: self.innerClcView.frame.height);
        
    }
    
    
    
}


