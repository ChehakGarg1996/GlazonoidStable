//
//  CatalogVC.swift
//  Glazonoid
//
//  Created by cubastion on 13/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore

let kCatalogBookMark: String = "com.glazanoid.catalog.bookMark"

enum Filter: String, CaseIterable {
    case likes, aToZ, zToA
    case circle = "Circle"
    case rectangle = "Rectangle"
    case custom = "Custom"
    case oval = "Oval"
    case livingRoom = "Circle4"
    case devotional = "Circle5"
    case bathroom = "Bathroom"
    case powderRoom = "Powder/Dresser"
    case otherProducts = "Circle8"
    case kidsRoom = "Kids"
    case nonFilter = "none"
}




class CatalogVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var catalogClcView: UICollectionView!
    @IBOutlet weak var filterView: UIView!
    var status = Bool()
    var arrayBookmarked = [CatalogModel]()
    var newImage = UIImage()
    var overlay = UIView()
    @IBOutlet weak var overlayView: UIView!
    private var db = Firestore.firestore()
    
    var catalogs: [CatalogModel]?
    
    var originalViewModels: [CatalogViewModel]?
    
    var filterType: Filter? {
        didSet {
            switch filterType {
            case .likes: cellViewModels = originalViewModels?.sorted(by: { (cat1, cat2) -> Bool in
                cat1.likes < cat2.likes
            })
            case .aToZ: cellViewModels = originalViewModels?.sorted(by: { (cat1, cat2) -> Bool in
                cat1.name < cat2.name
            })
            case .zToA: cellViewModels = originalViewModels?.sorted(by: { (cat1, cat2) -> Bool in
                cat1.name > cat2.name
            })
            case .circle, .rectangle, .custom, .oval:
                cellViewModels = originalViewModels?.compactMap ({ return $0.shape == filterType?.rawValue ? $0 : nil })
            case .livingRoom, .devotional, .bathroom, .powderRoom, .otherProducts, .kidsRoom:
                cellViewModels = originalViewModels?.compactMap ({ return $0.zone == filterType?.rawValue ? $0 : nil })
            default:
                cellViewModels = originalViewModels
            }
            self.filterView.isHidden = true
            self.overlayView.isHidden = true
            self.catalogClcView.reloadData()
        }
    }
    
    var cellViewModels: [CatalogViewModel]? {
        didSet {
            cellViewModelsBookMarked = self.cellViewModels?.compactMap({ (model) -> CatalogViewModel? in
                return model.isBookMarked ? model : nil
            })
        }
    }
    
    var cellViewModelsBookMarked: [CatalogViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

        filterBtn.layer.cornerRadius = filterBtn.frame.height/2
        catalogClcView.delegate = self
        catalogClcView.dataSource = self
        overlayView.isHidden = true
        fetchData()
        self.catalogClcView .register(UINib (nibName: "CatalogCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        filterView.isHidden = true
//        overlayView.isHidden = true
        filterType = .nonFilter
    }
    
    func fetchData() {
        
        db.collection("Catalog Uploads").getDocuments { (QuerySnapshot, Error) in
            if Error != nil{
                print(Error)
            }
            else{
                for document in (QuerySnapshot?.documents)! {
                    let dict = document.data()
                    let catalog  = CatalogModel(name: dict["name"] as? String, shape: dict["shape"] as? String, imageUrl: dict["imageUrl"] as? String, likes: dict["Likes"] as? Int ?? 0, about: dict["About"] as? String , zone: dict["zone"] as? String)
                    if self.catalogs == nil { self.catalogs = [] }
                    self.catalogs?.append(catalog)
                }
                self.originalViewModels = self.catalogs?.compactMap({ (model) -> CatalogViewModel? in
                    
                    
                    let bookMarkedData = UserDefaults.standard.data(forKey: kCatalogBookMark)
                    let bookmarkedNames = bookMarkedData != nil ? try? JSONDecoder().decode([String].self, from: bookMarkedData!) : nil
                    
                    let isBookMarked = bookmarkedNames?.contains(where: { (bModel) -> Bool in
                        return bModel == model.name
                    }) //TODO: check
                    return CatalogViewModel(
                        name: model.name ?? "",
                        shape: model.shape ?? "",
                        imageUrl: model.imageUrl ?? "",
                        likes: model.likes,
                        about: model.about ?? "",
                        zone: model.zone ?? "",
                        isExpanded: false,
                        isBookMarked: isBookMarked ?? false,
                        isLiked: false) {
                        let index = self.cellViewModels?.firstIndex(where: { $0.name == model.name})
                        //did Book Mark
                        guard
                            let idx = index,
                            self.cellViewModels?.count ?? 0 > idx else { return }
                        self.cellViewModels?[idx].didBookMark()
                        let bookMarkedData = UserDefaults.standard.data(forKey: kCatalogBookMark)
                        var bookmarkedNames = bookMarkedData != nil ? try? JSONDecoder().decode([String].self, from: bookMarkedData!) : nil
                        if bookmarkedNames == nil { bookmarkedNames = [] }
                        guard let name = model.name else { return }
                        if bookmarkedNames?.contains(name) ?? false {
                            bookmarkedNames?.append(name)
                        } else {
                            if let index = bookmarkedNames?.firstIndex(of: name) {
                                bookmarkedNames?.remove(at: index)
                            }
                        }
                        if let encoded = try? JSONEncoder().encode(bookmarkedNames) {
                            UserDefaults.standard.set(encoded, forKey: kCatalogBookMark)
                        }
                        self.catalogClcView.reloadData()
                    } didSelectShowMore: {
                        let index = self.cellViewModels?.firstIndex(where: { $0.name == model.name})
                        guard let idx = index else { return }
                        self.cellViewModels?[idx].didExpand()
                        self.catalogClcView.reloadData()
                    } didLikeClosure: {
                        let index = self.cellViewModels?.firstIndex(where: { $0.name == model.name})
                        guard let idx = index else { return }
                        self.cellViewModels?[idx].didLike()
                        self.catalogClcView.reloadData()
//                        index != nil ? self.didLikeFor(index: index!) : ()
                        // did like
                    } didShareWhatsapp: {
                        // did share
                        let index = self.cellViewModels?.firstIndex(where: { $0.name == model.name})
                        guard let idx = index else { return }
                        self.shareonWhatsapp(index: idx)
                       
                    }
                })
                
                self.filterType = .nonFilter
            }
        }
    }
    
    func shareonWhatsapp(index : Int){
        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            
            if let whatsappURL = URL(string: urlString) {
                
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    saveImage(index: index)
//                    let viewModel = cellViewModels?[index]
//                    guard let image = viewModel?.imageUrl else { return  }
                    if let imageData = self.newImage.jpegData(compressionQuality: 1.0) {
                        let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")!
                        do {
                            try imageData.write(to: tempFile, options: .atomic)
                            let documentController = UIDocumentInteractionController(url: tempFile)
                            documentController.uti = "net.whatsapp.image"
                           documentController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                        } catch {
                            print(error)
                        }
                    }
                    
                } else {
//                    let ac = UIAlertController(title: "MessageAletTitleText".localized, message: "AppNotFoundToShare".localized, preferredStyle: .alert)
//                    ac.addAction(UIAlertAction(title: "OKButtonText".localized, style: .default))
//                    present(ac, animated: true)
                    
                    print("Whatsapp isn't installed ")
                    
                    // Cannot open whatsapp
                }
            }
        }
    }
    
    
    func saveImage(index : Int) {
        let viewModel = cellViewModels?[index]
        guard let image = viewModel?.imageUrl else { return  }
        let bottomImage = UIImage(contentsOfFile: image)!
           let topImage = UIImage(named: "watermark")!

        let newSize = CGSize(width:100, height: 100) // set this to what you need
           UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        bottomImage.draw(in: CGRect(origin: .zero , size: newSize))
        topImage.draw(in: CGRect(origin: .zero, size: newSize))

        newImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
    }
    func didLikeFor(index: Int) {
        
        // update to firebase
        catalogs?[index].incrementLike()
        // put the above line before calling firebase method
        
        
        // put the following line in faliure closure
        //        catalogs?[index].decrementLike()
        // error show , clould not linke due to xx reason
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  self.catalogClcView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CatalogCell else { return UICollectionViewCell() }
        
//        let ratio = cell.imageDisplay.frame.width / cell.imageDisplay.frame.height
//        let newHeight = cell.imageDisplay.frame.width / ratio
        cell.imageHeight.constant = 250
        view.layoutIfNeeded()
        // to store all cells
        if status == true{
            cell.viewModel = cellViewModels?[indexPath.item]
        }
        //to store only bookmarked cells
        else{
            cell.viewModel = cellViewModelsBookMarked?[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if status == true{
            return cellViewModels?.count ?? 0
        }
        else{
            return cellViewModelsBookMarked?.count ?? 0
        }
        
    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //filter view show/hide
    @IBAction func onClickFilterBtn(_ sender: UIButton) {
        if filterView.isHidden == true {
            
            filterView.isHidden = false
            overlayView.isHidden = false
            
        }
        else{
            
            filterView.isHidden = true
           overlayView.isHidden = true

        }
        
        
    }
    
    
    @IBAction func filterByShapeBtn(_ sender: UIButton) {
        filterType = Filter.allCases[sender.tag]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.filterView.isHidden = true
        overlayView.isHidden = true
    }
    

}

extension CatalogVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let model = cellViewModels?[indexPath.row]
        let heightb = (model != nil && (model?.isExpanded ?? false)) ? 500 : 400
        return CGSize(width: view.frame.width, height: CGFloat(heightb))
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

struct CatalogModel: Codable {
    let name: String?
    let shape: String?
    let imageUrl: String?
    var likes: Int
    let about: String?
    let zone: String?
    
}

extension CatalogModel {
    mutating func incrementLike() {
        likes = likes + 1
    }
    
    mutating func decrementLike() {
        likes = likes - 1
    }
}


