//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 27.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController{

    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var videos: Videos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)

        vName.text = videos.vName
        vGenre.text = videos.vGenre
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights

        if videos.vImageData != nil {
        
            videoImage.image = UIImage(data: (videos.vImageData)!)
        
        } else {
        
            videoImage.image = UIImage(named: "imageNotAvailable")
        
        }
    }
    
    func preferredFontChanged(){
        
        vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
            let url = NSURL(string: videos.vVideoUrl)!
            let player = AVPlayer(URL: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.presentViewController(playerViewController, animated: true) {
                playerViewController.player?.play()
            }

    }
    

    
    deinit{
       
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }


}
