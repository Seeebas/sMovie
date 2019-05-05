//
//  MainSerieViewController.swift
//  sMovie
//
//  Created by Sebass on 02/05/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class MainSerieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GoToPageDetailProtocol {
    
    var tableSerie: UITableView = UITableView()
    
    var info: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        
        tableSerie.delegate = self
        tableSerie.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 0://Air today
            let cell = titleCell(title: Constants.categorySerie.airToday.rawValue, titleSize: 40, color: UIColor.white, indexPath: indexPath)
            
            return cell
            
        case 1:
            let cell = tableSerie.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlSerie,
                                                         params: Constants.urlParamAirToday,
                                                         separator: "/")
            cell.isMovie = false
            cell.goToPageDetail = self

            tableSerie.rowHeight = 210
            
            return cell
        case 2: //title - On the Air
            let cell = titleCell(title: Constants.categorySerie.onTheAir.rawValue, titleSize: 25, color: UIColor.white, indexPath: indexPath)
            
            return cell
            
        case 3:
            let cell = tableSerie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell
            
            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlSerie,
                                                         params: Constants.urlParamOnTheAir,
                                                         separator: "/")
            cell.isMovie = false
            cell.goToPageDetail = self
            
            tableSerie.rowHeight = 210
            
            return cell
        case 4: //title - Popular
            let cell = titleCell(title: Constants.categorySerie.popular.rawValue, titleSize: 25, color: UIColor.white, indexPath: indexPath)
            
            return cell
            
        case 5:
            let cell = tableSerie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell

            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlSerie,
                                                         params: Constants.urlParamDiscovery,
                                                         separator: "/")
            cell.isMovie = false
            cell.goToPageDetail = self

            tableSerie.rowHeight = 210

            return cell

        case 6: //title - Top Rated
            let cell = titleCell(title: Constants.categorySerie.topRated.rawValue, titleSize: 25, color: UIColor.white, indexPath: indexPath)

            return cell

        case 7:
            let cell = tableSerie.dequeueReusableCell(withIdentifier: "otherCell") as! SecondTableViewCell

            cell.urlRequest = UtilsLink.utils.createLink(mainLink: Constants.urlSerie,
                                                         params: Constants.urlParamTopRated,
                                                         separator: "/")
            cell.isMovie = false
            cell.goToPageDetail = self

            tableSerie.rowHeight = 210

            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    private func createTable(){
        
        tableSerie.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableSerie.backgroundColor = UIColor(hexString: "2B2F32")
        tableSerie.separatorStyle = .none
        
        tableSerie.register(UINib(nibName: "MainTitleViewCell", bundle: nil), forCellReuseIdentifier: "mainTitleCell")
        tableSerie.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        tableSerie.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "otherCell")
        
        self.view.addSubview(tableSerie)
        
    }
    
    
    private func titleCell(title:String,titleSize:CGFloat,color: UIColor, indexPath:IndexPath) -> MainTitleViewCell{
       
        let cell = tableSerie.dequeueReusableCell(withIdentifier: "mainTitleCell", for: indexPath) as! MainTitleViewCell
        tableSerie.rowHeight = 60
        
        cell.movieTitle(value: title)
        cell.movieTitleSize(of: titleSize)
        cell.movieTitleColor(with: color)
        
        return cell
        
    }
    
    
    func goToDetail(movie: Movie) {
        
        self.info = movie
        self.performSegue(withIdentifier: "movieDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail"{
            let detailPage = segue.destination as! MovieDetailViewController
            detailPage.movieInfo = self.info
            detailPage.isMovie = false
        
        }
    }
    
}
