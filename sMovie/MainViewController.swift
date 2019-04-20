//
//  MainViewController.swift
//  sMovie
//
//  Created by Sebass on 29/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GoToPageDetailProtocol {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var movieInfo: Movie = Movie()
    
    var totalCell = 8
    
    var lastUpdate: Bool = false{
        didSet{
            if(lastUpdate){
                mainTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.separatorStyle = .none
        
        mainTableView.register(UINib(nibName: "MainTitleViewCell", bundle: nil), forCellReuseIdentifier: "mainTitleCell")
           
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(!lastUpdate){
            if(indexPath.row == 7){
                lastUpdate = true
            }
        }
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        disableTableCellSelect(index: indexPath.row)
        
        switch indexPath.row {
       
        case 0://Title - Discovery (popular)
            let cell = titleCell(title: Constants.category.discovery.rawValue,titleSize: 40,color: UIColor.white, indexPath: indexPath)
            return cell
        case 1:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath) as! MainTableDiscoveryCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamDiscovery,
                                                         separator: "/")
            cell.goToPageDetail = self
            
            mainTableView.rowHeight = 210
            
            return cell
        case 2: //Title - Upcoming
            let cell = titleCell(title: Constants.category.upcoming.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 3:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MainTableMovieCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamUpcoming,
                                                         separator: "/")
            
            cell.goToPageDetail = self
            
            mainTableView.rowHeight = 210
            
            return cell
        case 4: //Title - NowPlaying
            let cell = titleCell(title: Constants.category.nowPlaying.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 5:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MainTableMovieCell

            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamNowPlaying,
                                                         separator: "/")
            cell.goToPageDetail = self
            
            mainTableView.rowHeight = 210
            
            return cell
        case 6: //Title - TopRated
            let cell = titleCell(title: Constants.category.topRated.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 7:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MainTableMovieCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamTopRated,
                                                         separator: "/")
            cell.goToPageDetail = self
            print(cell.urlRequest)
            
            mainTableView.rowHeight = 210
            
            return cell
        default:
           return UITableViewCell()

        }
    }

    
    //MARK: private methods
    
    private func titleCell(title:String,titleSize:CGFloat,color: UIColor, indexPath:IndexPath) -> MainTitleViewCell{
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainTitleCell", for: indexPath) as! MainTitleViewCell
        
        mainTableView.rowHeight = 60
    
        cell.movieTitle(value: title)
        cell.movieTitleSize(of: titleSize)
        cell.movieTitleColor(with: color)
        
        return cell
    }
    
    private func disableTableCellSelect(index: Int){
        if even(value: index){
            mainTableView.allowsSelection = false
        }
    }
    
    private func even(value:Int) -> Bool{
        return (value % 2 == 0) ? true : false
    }
    
    
    //MARK: Method that open the view Movie Detail
    
    func goToDetail(movie: Movie) {
        
        self.movieInfo = movie
        self.performSegue(withIdentifier: "movieDetail", sender: self)
        
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail"{
            let detailPage = segue.destination as! MovieDetailViewController
            detailPage.movieInfo = self.movieInfo
        }
    }
    
    

}
