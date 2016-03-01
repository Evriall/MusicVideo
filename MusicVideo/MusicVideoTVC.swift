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
    var sec:Bool = false
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sec = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        if sec {
        
             
        
        }
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
    }
    
    func preferredFontChanged(){
    
         print("The preferred Font has changed")
    
    
    }
    
    
    func didLoadData(videos: [Videos]){
        self.videos = videos

        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = ("The iTunes Top \(limit) Music Videos")
        tableView.reloadData()
    }
    func getAPICount() {
    
        
        if let APICnt = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as? Int {
            limit = APICnt
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MM yyyy HH:mm:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
    
    
    }
    func runAPI(){
        getAPICount()
        // Call API
        let api = APIManager()
        
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    
    }

    func reachabilityStatusChanged() {
        
        
        switch reachabilityStatus {
        case NOACCESS:
//            view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()){
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("Delete")
                }
            
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    action -> () in
                    print("OK")
                }
            
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
//            view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do not refresh API")
               
            } else {
            
                runAPI()
            
            }
        }
        
    }
    
    deinit{
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
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

    private struct storyboard {
    
        static let  cellReuseIdentifier = "cell"
        static let  segueIdentifier = "musicDetail"
    
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        let video = videos[indexPath.row]
        cell.video = video

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier {
        
            if let indexPath = tableView.indexPathForSelectedRow {
            
            
                let video = videos[indexPath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
                dvc.title = video.vArtist
                
             
            }
        
        
        }
    }

    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        runAPI()
    }
}
