//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 26.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {
    var videos = [Videos]()
    var filterSearch = [Videos]()
    var sec:Bool = false
    var limit = 10
    let resultSearchController = UISearchController(searchResultsController: nil)
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
        
        // Setup the Search Controller
        resultSearchController.searchResultsUpdater = self
        definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for artist"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        tableView.tableHeaderView = resultSearchController.searchBar
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
        var count = 0
        if resultSearchController.active {
            
            count = filterSearch.count
            
        } else {
            count = videos.count
        }
        return count
            
    }

    private struct storyboard {
    
        static let  cellReuseIdentifier = "cell"
        static let  segueIdentifier = "musicDetail"
    
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
            cell.video = videos[indexPath.row]
        }

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier {
        
            if let indexPath = tableView.indexPathForSelectedRow {
            
                
    
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                if resultSearchController.active {
                
                    dvc.videos = filterSearch[indexPath.row]
                    dvc.title = filterSearch[indexPath.row].vArtist
                }else {
                
                    dvc.videos = videos[indexPath.row]
                    dvc.title = videos[indexPath.row].vArtist
                }
                
                
                
             
            }
        
        
        }
    }

    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        if resultSearchController.active {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        }else {
            runAPI()
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
    func filterSearch(searchText: String){
    
//        let predicate:NSPredicate = NSPredicate(format: "vArtist contains[c] %@", searchText.lowercaseString)
//        let array = (videos as NSArray).filteredArrayUsingPredicate(predicate)
//        filterSearch = array as! [Videos]
        
        filterSearch = videos.filter{videos in return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString)}
        tableView.reloadData()
    
    }
}
