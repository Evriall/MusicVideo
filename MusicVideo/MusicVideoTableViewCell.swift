//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 26.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
    
        didSet{
        
             updateCell()
        
        }
    
    }
    
    @IBOutlet weak var rank: UILabel!

    @IBOutlet weak var musicImage: UIImageView!

    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell(){
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        musicTitle.text = video?.vName
        rank.text = video?.vRank.description
//        musicImage.image = UIImage(named: "imageNotAvailable")
        if video?.vImageData != nil {
        
            musicImage.image = UIImage(data: (video?.vImageData)!)
        
        } else {
        
            getVideoImage(video!, imageView: musicImage)
        
        }
        
    
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView){
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
        
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            var image : UIImage?
            if data != nil {
            
                video.vImageData = data
                image = UIImage(data: data!)
            
            
            }
            
            dispatch_async(dispatch_get_main_queue()){
            
                imageView.image = image
            
            
            }
        
        
        }
        
    
    
    }
}
