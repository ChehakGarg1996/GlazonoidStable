//
//  HomeVC.swift
//  Glazonoid
//
//  Created by cubastion on 11/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Lottie
class HomeVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
  
//    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var clcView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.isHidden = true
        self.clcView .register(UINib (nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        clcView.delegate = self
        clcView.dataSource = self
//        animationView = .init()
       

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  self.clcView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        cell.callBackAction = { [weak self] index in
            switch indexPath.section {
            case 0:
                let vc = CatalogVC()
                vc.status = true
                self?.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = TechnologyVC()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                let vc = RemoteVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            default: break
            }
        }
        cell.callBackAction1 = { [weak self] index in
            if indexPath.section == 2{
            let vc = AddProductVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        }
            
        switch indexPath.section {
        case 0:
            cell.setInnerCellData(indexpathSection: indexPath.section)
//            cell.heading = "Catalog"
        case 1 :
            cell.setInnerCellData(indexpathSection: indexPath.section)
//            cell.heading = "Catalog"
        case 2:
            cell.setInnerCellData(indexpathSection: indexPath.section)
        default:
            lblHeading.text = ""
        }
        return cell
    }
    

    @IBAction func onClickProfileBtn(_ sender: UIButton) {
        
        let vc = ProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension HomeVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: clcView.frame.size.width, height: clcView.frame.size.height);
    
    }
    
}
