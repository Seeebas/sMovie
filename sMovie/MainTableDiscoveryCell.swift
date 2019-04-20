//
//  MainTableDiscoveryCell.swift
//  sMovie
//
//  Created by Sebass on 29/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainTableDiscoveryCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var discoveryCollectionView: UICollectionView!
    
    var listMovie:[Movie] = []
    
    var goToPageDetail: GoToPageDetailProtocol?
    
    
    var urlRequest: String = ""{
        didSet{
            if (listMovie.isEmpty){
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
            listMovie = self.request.fromJSONtoMovies(json: json)
            
            discoveryCollectionView.reloadData()
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discoveryCollectionView.delegate = self
        discoveryCollectionView.dataSource = self
        
        discoveryCollectionView.showsHorizontalScrollIndicator = false
       
        discoveryCollectionView.register(UINib(nibName: "DiscoveryViewCell", bundle: nil), forCellWithReuseIdentifier: "discoveryMovieCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell = discoveryCollectionView.dequeueReusableCell(withReuseIdentifier: "discoveryMovieCell", for: indexPath) as! DiscoveryViewCell
        let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                  params: Constants.urlParamImage500w,
                                                  separator: "/")
        let url = URL(string: UtilsLink.utils.createLink(mainLink:imageUrl,
                                                         params:listMovie[indexPath.row].backdropURL,
                                                         separator: "/"))
        let palceHolder = UIImage(named: listMovie[indexPath.row].title)
        
        
        cell.discoveryImageButton.sd_setBackgroundImage(with: url,
                                                        for: .normal,
                                                        placeholderImage: palceHolder)
        
        cell.goToPagedetail = self.goToPageDetail
        
        cell.movie = listMovie[indexPath.row]
        
        return cell
        
    }
    
}
