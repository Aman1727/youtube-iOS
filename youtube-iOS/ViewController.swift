//
//  ViewController.swift
//  youtube-iOS
//
//  Created by Aman on 20/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.getVideos()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath)
        
//        Configure the cell with the data
        let title = self.videos[indexPath.row].title
        cell.textLabel?.text = title
//        Return the cell
        
        
        return cell
        
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController: ModelDelegate {
    
    func videosFetched(_ videos: [Video]) {
//        Set the returned videos to your videos property
        self.videos = videos
//        Refresh the tableview
        
        tableView.reloadData()
    }

}

