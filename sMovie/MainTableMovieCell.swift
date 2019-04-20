//
//  MainTableMovieCell.swift
//  sMovie
//
//  Created by Sebass on 29/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ChameleonFramework

class MainTableMovieCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
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
            
            movieCollectionView.reloadData()
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieCollectionView.showsHorizontalScrollIndicator = false
        
        movieCollectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieViewCell
        
        mappingCellWithRequest(cellMovie: cell,index: indexPath)
       //movieCollectionView.reloadItems(at: [indexPath])
        
        return cell
    }



    //MARK: MApping cell info with request info
    
    private func mappingCellWithRequest(cellMovie: MovieViewCell,index: IndexPath){
        
        cellMovie.movieTitleLable.text = listMovie[index.row].title
        cellMovie.movieRating.rating = listMovie[index.row].vote
        
        cellMovie.goToPagedetail = self.goToPageDetail
        cellMovie.movie = listMovie[index.row]
        
        
        if (Validate().isEmpty(value: listMovie[index.row].posterURL)){
            let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                      params: Constants.urlParamImage300w,
                                                      separator: "/")
            let url = URL(string: UtilsLink.utils.createLink(mainLink: imageUrl,
                                                             params: listMovie[index.row].posterURL,
                                                             separator: "/"))
            
            let palceHolder = UIImage(named: listMovie[index.row].title)
            
            
            cellMovie.imageButton.sd_setBackgroundImage(with: url,
                                                 for: .normal,
                                                 placeholderImage: palceHolder)
        }else{
            cellMovie.imageButton.setBackgroundImage(UIImage(named: "noImage"), for: .normal)
        }
        
    }

}


