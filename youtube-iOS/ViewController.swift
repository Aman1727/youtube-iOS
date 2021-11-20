//
//  ViewController.swift
//  youtube-iOS
//
//  Created by Aman on 20/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getVideos()
    }


}

