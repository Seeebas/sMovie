//
//  CastTableViewCell.swift
//  sMovie
//
//  Created by Sebass on 08/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{

    
    @IBOutlet weak var collectionViewCast: UICollectionView!
    
    var listCast: [Cast] = [] {
        didSet{
            collectionViewCast.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        collectionViewCast.delegate = self
        collectionViewCast.dataSource = self
        collectionViewCast.isScrollEnabled = true
        collectionViewCast.backgroundColor = UIColor(hexString: "2B2F32")
        collectionViewCast.frame = CGRect(x: 0, y: 0, width: 375, height: 125)
        
        if let layout = collectionViewCast.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 115)
            
        }
        collectionViewCast.register(UINib(nibName: "CastViewCell", bundle: nil), forCellWithReuseIdentifier: "castCell")
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCast.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastViewCell
        
        
        if (Validate().isEmpty(value: listCast[indexPath.row].imageLink)){
            let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                      params: Constants.urlParamImage300w,
                                                      separator: "/")
            let url = URL(string: UtilsLink.utils.createLink(mainLink: imageUrl,
                                                             params: listCast[indexPath.row].imageLink,
                                                             separator: "/"))
            let palceHolder = UIImage(named: listCast[indexPath.row].name)
            
            
            cell.castImage.sd_setBackgroundImage(with: url,
                                                 for: .normal,
                                                 placeholderImage: palceHolder)
            
            cell.castNameLabel.text = listCast[indexPath.row].name
        }else{
            cell.castImage.setBackgroundImage(UIImage(named: "noImage"), for: .normal)
            cell.castNameLabel.text = listCast[indexPath.row].name
        }
            
        return cell
    }
    
   
    
}
