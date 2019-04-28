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
            watchTableView.reloadData()
        }
    }
    
    var realm = try! Realm()
    
    @IBOutlet weak var segmentedWatchType: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTitleLabel()
        createTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func selectTypeButton(_ sender: Any) {
        
        print(segmentedWatchType.selectedSegmentIndex)
        
        switch segmentedWatchType.selectedSegmentIndex {
        case 0://Movie
            titleLabel.text = "Movies"
            break
        case 1:// Series
            titleLabel.text = "Series"
            break
        default:
            return
        }
        
    }
    
    //MARK: Methods for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWatchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = watchTableView.dequeueReusableCell(withIdentifier: "watchCell", for: indexPath) as! WatchTableViewCell
        mappingWatchListInfo(cellWatch: cell, index: indexPath.row)
       
        return cell
        

    }
    
    private func mappingWatchListInfo(cellWatch: WatchTableViewCell,index: Int){
        
        if (listOfWatchList!.count > 0){
            let imageUrl = UtilsLink.utils.createLink(mainLink: Constants.urlMovieImage,
                                                      params: Constants.urlParamImage300w,
                                                      separator: "/")
            let url = URL(string: imageUrl + listOfWatchList![index].posterURL)
            
            cellWatch.poster.sd_setImage(with: url, placeholderImage: UIImage(named: listOfWatchList![index].posterURL))
            cellWatch.watchRank.text = "\(index+1)"
            cellWatch.title.text = listOfWatchList![index].title
            cellWatch.directorValueLabel.text = listOfWatchList![index].directorName
            cellWatch.ratingStar.rating = listOfWatchList![index].vote
            cellWatch.ratingLabel.text = "\((listOfWatchList![index].vote*10)/5)"
            
        }

    }

}
