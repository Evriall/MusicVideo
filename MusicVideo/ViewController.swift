//
//  ViewController.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(result: String){
    
//        print(result)
        
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default){ action -> Void in
        
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    
    }

}

