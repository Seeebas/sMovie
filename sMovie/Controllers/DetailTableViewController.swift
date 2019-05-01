//
//  DetailTableViewController.swift
//  sMovie
//
//  Created by Sebass on 04/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import ChameleonFramework

import SwiftyJSON

class DetailTableViewController: UITableViewController {
    
    let imageBigPoster : UIImageView = UIImageView()
    let imageSmallPoster : UIImageView = UIImageView()
    let movieNameLabel: UILabel = UILabel()
    let headerView: UIView = UIView()
    
    let tableInfoSize: Int = 6
    
    var movie: Movie = Movie()
    var isMovie: Bool = true
    var listCast: [Cast] = []
    var listCrew: [Cast] = []
    var listRecomendation: [Movie] = []
    var listCastConvert: [Cast] = []
    var gender = ""
    
    var request = Request()
    
    
    // TODO: melhorar a forma como faço o request pois agora vamos ter 2 tipos movie e serie
    //       adicionar o request para as series usando o isMovie = false
    
    var jsonMovieExtra: JSON = JSON.null{
        didSet{
            self.request.fromJSONtoMovieGenders(movie: movie, json: jsonMovieExtra)

            for (index,gen) in movie.genres.enumerated(){
               
                if(index == (movie.genres.count - 1)){
                    gender += gen.genres
                }else{
                    gender += gen.genres+","
                }
            }            
            // Request for Cast movie
            if self.jsonCast.isEmpty{
                let urlCast = createUrl(paramExtra: Constants.urlParamCast)

                request.GET(url: urlCast,
                            parameters: Constants.paramsStandard)
                
                request.dispatchGroup.notify(queue: .main) {
                    self.jsonCast = self.request.jsonRequest
                }
            }
        }
    }
    
    var jsonCast: JSON = JSON.null{
        didSet{
            listCast = self.request.fromJSONtoCast(json: jsonCast,info:Constants.requestInfoCast)
            listCrew = self.request.fromJSONtoCast(json: jsonCast,info: Constants.requuestInfoCrew)
            movie.directorName = (!listCrew.isEmpty) ? listCrew[0].name : "nd"
            // Request for Movie recomendation
            if self.jsonMovieRecomendation.isEmpty{
                
                let urlRecomendation = createUrl(paramExtra: Constants.urlParamRecommendation)
                
                request.GET(url: urlRecomendation,
                            parameters: Constants.paramsStandard)
                
                request.dispatchGroup.notify(queue: .main) {
                    self.jsonMovieRecomendation = self.request.jsonRequest
                }
            }
        }
    }
    
    var jsonMovieRecomendation: JSON = JSON.null{
        didSet{
            listRecomendation = self.request.fromJSONtoMovies(json: jsonMovieRecomendation)
            listCastConvert = convertMovieToCast(movieList: listRecomendation)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTableUI()
        
        //Request for movie Extra info
    
        let url = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                             params: movie.id,
                                             separator: "/")
        request.GET(url: url,parameters: Constants.paramsStandard)

        request.dispatchGroup.notify(queue: .main) {
            self.jsonMovieExtra = self.request.jsonRequest
        }
        
   
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInfoSize
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellRateGender", for: indexPath) as! DetailRateGenderViewCell
            tableView.rowHeight = 85

            mappingGenderAndRating(mapping: cell)

            return cell
        }
        if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOverview", for: indexPath) as! DetailOverviewViewCell

            mappingYearAndStroyline(mapping: cell)
            return cell
        }
        if(indexPath.row == 2){// Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainTitleCell", for: indexPath) as! MainTitleViewCell

            tableView.rowHeight = 60
            cell.movieTitle(value: "Cast")
            cell.movieTitleSize(of: 20)
            cell.movieTitleColor(with: UIColor.white)

            return cell
        }
        if(indexPath.row == 3){//Cast
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCastTable",for:indexPath) as! CastTableViewCell
            cell.listCast = self.listCast
            tableView.rowHeight = 125
            return cell

        }
        if(indexPath.row == 4){// Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainTitleCell", for: indexPath) as! MainTitleViewCell

            tableView.rowHeight = 60
            cell.movieTitle(value: "Recomendation")
            cell.movieTitleSize(of: 20)
            cell.movieTitleColor(with: UIColor.white)

            return cell
        }
        if(indexPath.row == 5){//Recomentadion movie
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCastTable",for:indexPath) as! CastTableViewCell
            cell.listCast = self.listCastConvert
            tableView.rowHeight = 125
            return cell
            
        }
         return UITableViewCell()
    }
    
    
    //MARK: Method to streach the image
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  250 - (scrollView.contentOffset.y + 250)
        
        let height = max(y,150)//min( max(y,250),250)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        
    }

    
    //MARK: Cell and Table background changes
    
    private func updateTableUI(){
        
        tableView.backgroundColor = UIColor(hexString: "2B2F32")
        
        tableView.register(UINib(nibName: "DetailRateGenderViewCell", bundle: nil), forCellReuseIdentifier: "cellRateGender")
        tableView.register(UINib(nibName: "DetailOverviewViewCell", bundle: nil), forCellReuseIdentifier: "cellOverview")
        tableView.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: "cellCastTable")
        tableView.register(UINib(nibName: "MainTitleViewCell", bundle: nil), forCellReuseIdentifier: "mainTitleCell")

        tableView.contentInset = UIEdgeInsets(top: 290, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
    }
    
    
    //MARK: Mapping values for Gender,Year,Storyline,Cast etc..
    
    /**
     This method mapping the first cell info : Gender and Rating
     **/
    private func mappingGenderAndRating(mapping cell: DetailRateGenderViewCell ){
        
        cell.genderLabel.text = gender
        cell.ratingStars.rating = movie.vote
        cell.movie = self.movie
        
    }
    
    /**
     This method mapping the second cell info : Year, Country,Length and Storyline
     **/
    private func mappingYearAndStroyline(mapping cell: DetailOverviewViewCell){
        tableView.rowHeight = 300
        
        cell.yearInfoLabel.text = String(movie.releaseDate.prefix(4))
        cell.countryInfoLabel.text = movie.language.uppercased()
        cell.lengthInfoLabel.text = movie.runtime + " min"
        
        cell.storyLineLabel.text = "Overview"
        cell.storyLineLabel.font = UIFont(name: "Futura", size: 20)
        cell.storyLineLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.overviewInfoLabel.text = movie.overview
        
    }
    
    /**Needed to do this in order to use Cast View Cell**/
    private func convertMovieToCast(movieList: [Movie])->[Cast]{
        var listMovieCast: [Cast] = []
        
        for movie in movieList{
            var cast = Cast()
            cast.id = movie.id
            cast.imageLink = movie.posterURL
            cast.name = movie.title
            listMovieCast.append(cast)
        }
        
        return listMovieCast
        
    }
    
    
    private func createUrl(paramExtra: String)->String{
        var url = ""
        
        if (isMovie){
            url = UtilsLink.utils.createLink(mainLink: Constants.urlMovie,
                                             params: movie.id,paramExtra,
                                             separator: "/")
        }else{
            url = UtilsLink.utils.createLink(mainLink: Constants.urlSerie,
                                             params: movie.id,paramExtra,
                                             separator: "/")
        }
        return url
    }

    
}


