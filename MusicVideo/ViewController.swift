//
//  ViewController.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=30/json", completion: didLoadData)
    }
    
    
    
    
    func didLoadData(videos: [Videos]){
         self.videos = videos
//        print(videos.count)
        for item in videos {
            
//            print(item.vName)
        }
        
//        for (index, item) in videos.enumerate() {
//        
//            print(index, ") name = ", item.vName)
//        
//        }
        
//        for i in 0..<videos.count {
//        
//            let video = videos[i]
//            print(i, ") name = ", video.vName)
//        
//        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    func reachabilityStatusChanged() {
    
    
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WiFi"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default: return
        }
    
    }
    
    deinit{
    
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     return videos.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.detailTextLabel?.text = video.vName
//        cell.imageView?.image = video
        return cell
        
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

