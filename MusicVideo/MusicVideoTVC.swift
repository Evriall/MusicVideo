//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 26.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        tableView.reloadData()
    }

    func reachabilityStatusChanged() {
        
        
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
//        displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
//        displayLabel.text = "Reachable with WiFi"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
//        displayLabel.text = "Reachable with Cellular"
        default: return
        }
        
    }
    
    deinit{
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.detailTextLabel?.text = video.vName
        //        cell.imageView?.image = video
        return cell

        return cell
    }

}
