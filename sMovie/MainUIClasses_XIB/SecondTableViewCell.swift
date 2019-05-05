//
//  SecondTableViewCell.swift
//  sMovie
//
//  Created by Sebass on 05/05/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    var list:[Movie] = []
    
    var isMovie = true
    
    var goToPageDetail: GoToPageDetailProtocol?
    
    let otherCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 123, height: 210)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 210),
                                          collectionViewLayout: layout)
        
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor(hexString: "2B2F32")
        collection.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        
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
            
            otherCollectionView.reloadData()            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(otherCollectionView)
        
        otherCollectionView.delegate = self
        otherCollectionView.dataSource = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mappingCellWithRequest(index: indexPath)
        
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: MApping cell info with request info
    
    private func mappingCellWithRequest(index: IndexPath)->MovieViewCell{
        
        let cell = otherCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: index) as! MovieViewCell
        cell.movieTitleLable.text = list[index.row].title
        cell.movieRating.rating = list[index.row].vote
        
        cell.goToPagedetail = self.goToPageDetail
        cell.movie = list[index.row]
        
        
        if (Validate().isEmpty(value: list[index.row].posterURL)){
            let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                      params: Constants.urlParamImage300w,
                                                      separator: "/")
            let url = URL(string: UtilsLink.utils.createLink(mainLink: imageUrl,
                                                             params: list[index.row].posterURL,
                                                             separator: "/"))
            
            let palceHolder = UIImage(named: list[index.row].title)
            
            
            cell.imageButton.sd_setBackgroundImage(with: url,
                                                        for: .normal,
                                                        placeholderImage: palceHolder)
        }else{
            cell.imageButton.setBackgroundImage(UIImage(named: "noImage"), for: .normal)
        }
        
        return cell
        
    }
}
