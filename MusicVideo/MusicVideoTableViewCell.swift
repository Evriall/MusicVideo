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
    
        musicTitle.text = video?.vName
        rank.text = video?.vRank.description
        musicImage.image = UIImage(named: "imageNotAvailable")
        
    
    }
}
