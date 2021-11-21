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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//         Confirm that a video was selected
//        guard tableView.indexPathForSelectedRow != nil else {
//            return
//        }
        
//        Get a reference to the video that was tapped on
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
//        Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
//        Set the video property of the detail view controller
        detailVC.video = selectedVideo
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
//        Configure the cell with the data
        let video = self.videos[indexPath.row]
        cell.setCell(video)
        
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

