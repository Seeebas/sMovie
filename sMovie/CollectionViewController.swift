//
//  CollectionViewController.swift
//  sMovie
//
//  Created by Sebass on 17/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate



}
