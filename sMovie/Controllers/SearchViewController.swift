//
//  SearchViewController.swift
//  sMovie
//
//  Created by Sebass on 19/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    
    
    let search = UISearchBar()
    let tableSearch = UITableView()
    let container = UIView()
    var segment = UISegmentedControl()
    
    var listMovie : [Movie] = []
    var movieInfo: Movie = Movie()
    
    
    var jsonMovieSearch: JSON = JSON.null{
        didSet{
            print(segment.selectedSegmentIndex)
            if(segment.selectedSegmentIndex == 0){
                 listMovie = request.fromJSONtoMovies(json: jsonMovieSearch)
            }else{
                 listMovie = request.fromJSONtoSeries(json: jsonMovieSearch)
            }
           
            tableSearch.reloadData()
        }
    }
    
    let request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
    
        createContainer()
        
        createSegmentPage()
        createSearchBar()
        
        search.delegate = self
        tableSearch.delegate = self
        tableSearch.dataSource = self
        
        
    }
    //MARK: search bar method
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty){
            listMovie.removeAll()
            tableSearch.reloadData()
        }else{
            
            Constants.paramsStandard.updateValue(searchText, forKey: Constants.urlParamQuery)
            
            var url = ""
            if (segment.selectedSegmentIndex == 0){//movie search
                url = UtilsLink.utils.createLink(mainLink: Constants.urlSearch,
                                                 params: Constants.urlParamMovie,
                                                 separator:"/")
            }else{// serie search
                url = UtilsLink.utils.createLink(mainLink: Constants.urlSearch,
                                                 params: Constants.urlParamSerie,
                                                 separator:"/")
            }
            
            request.GET(url: url,
                        parameters:  Constants.paramsStandard)
            
            request.dispatchGroup.notify(queue: .main) {
                self.jsonMovieSearch = self.request.jsonRequest
            }
        }
    }
    
    //MARK: tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableSearch.dequeueReusableCell(withIdentifier: "watchCell", for: indexPath) as! WatchTableViewCell
        mappingWatchListInfo(cellWatch: cell, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        movieInfo = listMovie[indexPath.row]
        
        //self.performSegue(withIdentifier: "movieDetail", sender: self)
    }
    

    //MARK: private methods
    private func mappingWatchListInfo(cellWatch: WatchTableViewCell,index: Int){
        
       
        if (listMovie.count > 0){
            if (Validate().isEmpty(value: listMovie[index].posterURL)){
                let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                          params: Constants.urlParamImage300w,
                                                          separator: "/")
                let url = URL(string: imageUrl + listMovie[index].posterURL)
                
                cellWatch.poster.sd_setImage(with: url, placeholderImage: UIImage(named: listMovie[index].posterURL))
                cellWatch.watchRank.isHidden = true
                cellWatch.rankImage.isHidden = true
                cellWatch.title.text = listMovie[index].title
                cellWatch.directorValueLabel.text = listMovie[index].directorName
                cellWatch.ratingStar.rating = listMovie[index].vote
                cellWatch.ratingLabel.text = "\((listMovie[index].vote*10)/5)"
                //change director info for release date
                cellWatch.directorInfoLabel.text = "Release:"
                cellWatch.directorValueLabel.text = listMovie[index].releaseDate
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func createSearchBar(){
        search.frame = CGRect(x: 0, y: 30, width: view.frame.width, height: 44)
        search.barTintColor = UIColor(hexString: "2B2F32")
        
        self.container.addSubview(search)
        
    }
    
    private func createTableView(){
        tableSearch.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        tableSearch.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        tableSearch.backgroundColor = UIColor(hexString: "2B2F32")
        tableSearch.register(UINib(nibName: "WatchTableViewCell", bundle: nil), forCellReuseIdentifier: "watchCell")
        tableSearch.separatorStyle = .none
        tableSearch.rowHeight = 175
        
        self.view.addSubview(tableSearch)
        
    }
    
    private func createSegmentPage(){
        
        let image1 = UIImage(named: "movie-1")
        let image2 = UIImage(named: "serie-1")
        
        let items = [image1,image2]
        
        segment = UISegmentedControl(items: items as [Any])
        segment.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 29)
        segment.selectedSegmentIndex = 0
        
        segment.backgroundColor = UIColor(hexString: "2B2F32")
        segment.tintColor = UIColor.white
        
        segment.addTarget(self, action: #selector(chooseSegmet(sender:)), for: .valueChanged)
        
        self.container.addSubview(segment)
    }
    
    
    
    @objc private func chooseSegmet(sender: UISegmentedControl){
        
        listMovie.removeAll()
        search.text = ""
        tableSearch.reloadData()

    }
    
    private func createContainer(){
        container.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 90)
        container.backgroundColor = UIColor.clear
        container.contentMode = .scaleAspectFill
        container.clipsToBounds = true
        container.backgroundColor = UIColor.clear
        
        self.view.addSubview(container)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  90 - (scrollView.contentOffset.y + 90)

        let height = max(y,30)

        container.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: height)

    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail"{
            let detailPage = segue.destination as! MovieDetailViewController
            detailPage.movieInfo = self.movieInfo
        }
    }
 

}
