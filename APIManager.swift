//
//  APIManager.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import Foundation

class APIManager{

    func loadData(urlString: String, completion: (result: String) -> Void) {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: error!.localizedDescription)
                    }
                } else {
                    //Added for JSONSerialization
//                    print(data)
                    do{

                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictioanry,
                        feed = json["feed"] as? JSONDictioanry,
                        entries = feed["entry"] as? JSONArray {

//                            print(json)
                            
                            var videos = [Videos]()
                            for entry in entries {
                            
                                let entry = Videos(data: entry as! JSONDictioanry)
                                videos.append(entry)
                                print(entry.vName)
                            
                            }
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)){

                            
                                dispatch_async(dispatch_get_main_queue()){
                                
                                
                                    completion(result: "JSONSerialization successfull")
                                
                                }
                            
                            }

                        }
                    
                    } catch {
                    
                        dispatch_async(dispatch_get_main_queue()){
                            
                            
                            completion(result: "JSONSerialization successfull")
                            
                        }

                    
                    }

                }

        
        }
        task.resume()
     }

}
