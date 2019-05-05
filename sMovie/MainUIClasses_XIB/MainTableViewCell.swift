//
//  MainTableViewCell.swift
//  sMovie
//
//  Created by Sebass on 04/05/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    var list:[Movie] = []
    
    var isMovie = true
    
    var goToPageDetail: GoToPageDetailProtocol?

    let mainCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 375, height: 210)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 210),
                                          collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor(hexString: "2B2F32")
        collection.register(UINib(nibName: "DiscoveryViewCell", bundle: nil), forCellWithReuseIdentifier: "discoveryMovieCell")
        
        return collection
    }()
    
    
    var urlRequest: String = ""{
        didSet{
            if (list.isEmpty){
                request.GET(url: urlRequest,parameters: Constants.paramsStandard)
                
                request.dispatchGroup.notify(queue: .main) {
                    self.json = self.request.jsonRequest
                }
            }
        }
    }
    
    var request = Request()
    
    var json: JSON = JSON.null{
        didSet{
            
            if(isMovie){
                 list = self.request.fromJSONtoMovies(json: json)
            }else{
                 list = self.request.fromJSONtoSeries(json: json)
            }
            
            mainCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(mainCollectionView)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "discoveryMovieCell", for: indexPath) as! DiscoveryViewCell
        
        let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                  params: Constants.urlParamImage500w,
                                                  separator: "/")
        let url = URL(string: UtilsLink.utils.createLink(mainLink:imageUrl,
                                                         params:list[indexPath.row].backdropURL,
                                                         separator: "/"))
        let palceHolder = UIImage(named: list[indexPath.row].title)
        
        
        cell.discoveryImageButton.sd_setBackgroundImage(with: url,
                                                        for: .normal,
                                                        placeholderImage: palceHolder)

        cell.goToPagedetail = self.goToPageDetail
        
        cell.movie = list[indexPath.row]
        return cell
    }
    
    
    
    
    
}
