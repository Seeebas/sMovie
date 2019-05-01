//
//  WatchListViewController.swift
//  sMovie
//
//  Created by Sebass on 10/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import RealmSwift

class WatchListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let titleLabel: UILabel = UILabel()
    let watchTableView: UITableView = UITableView()
    
    var listOfWatchList: Results<WatchMovie>? {
        didSet{
            print("did set")
            watchTableView.reloadData()
        }
    }
    
    var whichOneList = [Movie](){
        didSet{
           // watchTableView.reloadData()
        }
    }
    
    var realm = try! Realm()
    
    var movieInfo: Movie = Movie()
    
    @IBOutlet weak var segmentedWatchType: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTitleLabel()
        createTableView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        (segmentedWatchType.selectedSegmentIndex==0) ? whichOne(isMovie: true)
                                                     : whichOne(isMovie: false)
        
        print(segmentedWatchType.selectedSegmentIndex)
    }
    
    //MARK: Creating the UI for this page
    private func createTitleLabel(){
    
        titleLabel.frame = CGRect(x: 15, y: 80, width: 200, height: 100)
        titleLabel.text = "Movies"
        titleLabel.font = UIFont(name: "Futura", size: 50)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        view.addSubview(titleLabel)
    
    }
    
    private func createTableView(){
        watchTableView.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height)
        
        //watchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        watchTableView.register(UINib(nibName: "WatchTableViewCell", bundle: nil), forCellReuseIdentifier: "watchCell")
        watchTableView.rowHeight = 150
        watchTableView.backgroundColor = UIColor.clear
        //watchTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        watchTableView.separatorStyle = .none
        watchTableView.delegate = self
        watchTableView.dataSource = self
        view.addSubview(watchTableView)
    }
    
    //MARK: Method that loading the info for this page
    private func loadData(){
        
        listOfWatchList = realm.objects(WatchMovie.self)
      
    }
    
    @IBAction func selectTypeButton(_ sender: Any) {
        
        switch segmentedWatchType.selectedSegmentIndex {
        case 0://Movie
            titleLabel.text = "Movies"
            whichOne(isMovie: true)
            watchTableView.reloadData()
            break
        case 1:// Series
            titleLabel.text = "Series"
            whichOne(isMovie: false)
            watchTableView.reloadData()
            break
        default:
            return
        }
        
    }
    
    //MARK: Methods for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whichOneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = watchTableView.dequeueReusableCell(withIdentifier: "watchCell", for: indexPath) as! WatchTableViewCell
        mappingWatchListInfo(cellWatch: cell, index: indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieInfo = whichOneList[indexPath.row].self
        
        self.performSegue(withIdentifier: "movieDetail", sender: self)
    }
    private func mappingWatchListInfo(cellWatch: WatchTableViewCell,index: Int){
        if (!whichOneList.isEmpty){
            
            let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                      params: Constants.urlParamImage300w,
                                                      separator: "/")
            let url = URL(string: imageUrl + whichOneList[index].posterURL)
            
            cellWatch.poster.sd_setImage(with: url, placeholderImage: UIImage(named: whichOneList[index].posterURL))
            cellWatch.watchRank.text = "\(index+1)"
            cellWatch.title.text = whichOneList[index].title
            cellWatch.directorValueLabel.text = whichOneList[index].directorName
            cellWatch.ratingStar.rating = whichOneList[index].vote
            cellWatch.ratingLabel.text = "\((whichOneList[index].vote*10)/5)"
        
        }
        
    }
    /** This method is used for mapping Movie in one side of the segmented and Serie in other segmented**/
    private func whichOne(isMovie: Bool){
        
        whichOneList.removeAll()
        if (listOfWatchList!.count > 0){
            
            for movie in listOfWatchList!{
                if (movie.isMovie == isMovie){
                    let newWatch = Movie()
                    
                    newWatch.id = movie.id
                    newWatch.title = movie.title
                    newWatch.originalTitle = movie.originalTitle
                    newWatch.overview = movie.overview
                    newWatch.posterURL = movie.posterURL
                    newWatch.backdropURL = movie.backdropURL
                    newWatch.vote = movie.vote
                    newWatch.releaseDate = movie.releaseDate
                    newWatch.runtime = movie.runtime
                    newWatch.language = movie.language
                    newWatch.directorName = movie.directorName
                    newWatch.isMovie = movie.isMovie
                    
                    whichOneList.append(newWatch)
                }
            }
        }
        
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "movieDetail"){
            let detailPage = segue.destination as! MovieDetailViewController
            (segmentedWatchType.selectedSegmentIndex == 0) ? (detailPage.isMovie = true)
                                                           : (detailPage.isMovie = false)
            detailPage.movieInfo = self.movieInfo
        }
     }
    
}
