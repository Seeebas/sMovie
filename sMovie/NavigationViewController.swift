//
//  NavigationViewController.swift
//  sMovie
//
//  Created by Sebass on 19/05/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class NavigationViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonInfo(_ sender: Any) {
        self.performSegue(withIdentifier: "info", sender: self)
    }
}
