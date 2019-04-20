//
//  MovieDetailViewController.swift
//  sMovie
//
//  Created by Sebass on 02/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SDWebImage
import ChameleonFramework

class MovieDetailViewController: UIViewController {

    var movieInfo: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableDetail = DetailTableViewController()
        tableDetail.movie = movieInfo
        self.addChild(tableDetail)
        view.addSubview(tableDetail.tableView)
        
        let headerView = createView(headerView: tableDetail.headerView)
        //big poster
        let imageBigPoster =  createImageBigPoster(image: tableDetail.imageBigPoster)
        headerView.addSubview(imageBigPoster)
        
        //small poster
        let imageSmallPoster = createImageSmallPoster(image: tableDetail.imageSmallPoster)
        headerView.addSubview(imageSmallPoster)
        
        //label movie title
        let labelTitle = createLabel(label: tableDetail.movieNameLabel)
        headerView.addSubview(labelTitle)
        
        view.addSubview(headerView)
        
       
    }
    
    /**This view purpose if for big and small poster and the title of the movie**/
    private func createView(headerView: UIView)->UIView{
        headerView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 250)
        
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        
        return headerView
    }
    
    
    private func createImageBigPoster(image: UIImageView)-> UIImageView{
        image.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 210)
        
        
        let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                  params: Constants.urlParamImage500w,
                                                  separator: "/")
        let url = URL(string: imageUrl + movieInfo.backdropURL)
        
        image.sd_setImage(with: url, placeholderImage: UIImage(named: movieInfo.title))
        
        
        let shadow = UIView()
        shadow.frame = image.bounds
        shadow.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom,
                                         withFrame: CGRect(x: 0, y: 64, width: view.frame.width, height: 210),
                                         andColors: [UIColor.clear,
                                                     UIColor.clear,
                                                     UIColor(hexString: "2B2F32")!])
        
        image.addSubview(shadow)
        
        return image
        
    }
    
    private func createImageSmallPoster(image: UIImageView)-> UIImageView{
        image.frame = CGRect(x: 20, y: 190, width: 105, height: 140)
        image.image = UIImage(named: "capp")
        image.roundCorners(radius: 15)
        
        
        let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                  params: Constants.urlParamImage500w,
                                                  separator: "/")
        let url = URL(string: imageUrl + movieInfo.posterURL)
        
        image.sd_setImage(with: url, placeholderImage: UIImage(named: movieInfo.title))
        
        return image
        
    }
    
    private func createLabel(label:UILabel)->UILabel{
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.numberOfLines = 0
        label.frame = CGRect(x: 130, y: 180, width: 200, height:150)
        label.textColor = UIColor.white
        
        label.text = movieInfo.title
        
        label.layer.shadowColor = UIColor.flatBlackDark.cgColor
        label.layer.shadowRadius = 6.0
        label.layer.shadowOpacity = 3.0
        label.layer.shadowOffset = CGSize(width:6, height:6)
        
        return label
    }
    
    

}



