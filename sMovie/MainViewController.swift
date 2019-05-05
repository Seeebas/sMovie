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
    
    var tableMovie:UITableView = UITableView()
    
    var movieInfo: Movie = Movie()
    
//    var lastUpdate: Bool = false{
//        didSet{
//            if(lastUpdate){
//                mainTableView.reloadData()
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        
        tableMovie.delegate = self
        tableMovie.dataSource = self
           
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if(!lastUpdate){
//            if(indexPath.row == 7){
//                lastUpdate = true
//            }
//        }
// 
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        disableTableCellSelect(index: indexPath.row)
        
        switch indexPath.row {
       
        case 0://Title - Discovery (popular)
            let cell = titleCell(title: Constants.categoryMovie.discovery.rawValue,titleSize: 40,color: UIColor.white, indexPath: indexPath)
            return cell
        case 1:
            let cell = tableMovie.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamDiscovery,
                                                         separator: "/")
            cell.goToPageDetail = self
            
            tableMovie.rowHeight = 210
            
            return cell
        case 2: //Title - Upcoming
            let cell = titleCell(title: Constants.categoryMovie.upcoming.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 3:
            let cell = tableMovie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamUpcoming,
                                                         separator: "/")
            
            cell.goToPageDetail = self
            
            tableMovie.rowHeight = 210
            
            return cell
        case 4: //Title - NowPlaying
            let cell = titleCell(title: Constants.categoryMovie.nowPlaying.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 5:
            let cell = tableMovie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell

            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamNowPlaying,
                                                         separator: "/")
            cell.goToPageDetail = self
            
            tableMovie.rowHeight = 210
            
            return cell
        case 6: //Title - TopRated
            let cell = titleCell(title: Constants.categoryMovie.topRated.rawValue,titleSize: 25,color: UIColor.white, indexPath: indexPath)
            return cell
        case 7:
            let cell = tableMovie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                                         params: Constants.urlParamTopRated,
                                                         separator: "/")
            cell.goToPageDetail = self
            
            tableMovie.rowHeight = 210
            
            return cell
        default:
           return UITableViewCell()

        }
    }

    
    //MARK: private methods
    
    private func titleCell(title:String,titleSize:CGFloat,color: UIColor, indexPath:IndexPath) -> MainTitleViewCell{
        let cell = tableMovie.dequeueReusableCell(withIdentifier: "mainTitleCell", for: indexPath) as! MainTitleViewCell
        
        tableMovie.rowHeight = 60
    
        cell.movieTitle(value: title)
        cell.movieTitleSize(of: titleSize)
        cell.movieTitleColor(with: color)
        
        return cell
    }
    
    private func disableTableCellSelect(index: Int){
        if even(value: index){
            tableMovie.allowsSelection = false
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
    
    
    
    private func createTable(){
        
        tableMovie.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableMovie.backgroundColor = UIColor(hexString: "2B2F32")
        tableMovie.separatorStyle = .none
        
        tableMovie.register(UINib(nibName: "MainTitleViewCell", bundle: nil), forCellReuseIdentifier: "mainTitleCell")
        tableMovie.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        tableMovie.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "otherCell")
        
        self.view.addSubview(tableMovie)
        
    }
    

}
