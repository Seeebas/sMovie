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
    
    var listMovie : [Movie] = []
    
    
    var jsonMovieSearch: JSON = JSON.null{
        didSet{
            listMovie = request.fromJSONtoMovies(json: jsonMovieSearch)
            tableSearch.reloadData()
        }
    }
    
    let request = Request()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTableView()
        createSearchBar()
        
        search.delegate = self
        tableSearch.delegate = self
        tableSearch.dataSource = self
        
        
    }
    //MARK: search bar method
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty){
            listMovie = []
            tableSearch.reloadData()
        }else{
        
        Constants.paramsStandard.updateValue(searchText, forKey: Constants.urlParamQuery)
        
        request.GET(url: Constants.urlSearch,
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
                
            }
        }
        
    }
    
    private func createSearchBar(){
        search.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 44)
        search.barTintColor = UIColor(hexString: "2B2F32")
        
        self.view.addSubview(search)
    }
    
    private func createTableView(){
        tableSearch.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        tableSearch.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        tableSearch.backgroundColor = UIColor(hexString: "2B2F32")
        tableSearch.register(UINib(nibName: "WatchTableViewCell", bundle: nil), forCellReuseIdentifier: "watchCell")
        tableSearch.separatorStyle = .none
        tableSearch.rowHeight = 175
        
        self.view.addSubview(tableSearch)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
