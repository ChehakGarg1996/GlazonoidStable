//
//  CatalogVC.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit

class CatalogVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
    @IBOutlet weak var catalogClcView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogClcView.delegate = self
        catalogClcView.dataSource = self
         self.catalogClcView .register(UINib (nibName: "CatalogCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  self.catalogClcView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CatalogCell else { return UICollectionViewCell() }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension CatalogVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
