//
//  ViewController.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]){
        print(reacabilityStatus)
        self.videos = videos
        
        for item in videos {
            
            print(item.vName)
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
    
    }
    
}

