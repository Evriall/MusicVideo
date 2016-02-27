//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 27.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var videos: Videos?
    override func viewDidLoad() {
        super.viewDidLoad()
        vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        vName.text = videos?.vName
        vGenre.text = videos?.vGenre
        vPrice.text = videos?.vPrice
        vRights.text = videos?.vRights

        if videos?.vImageData != nil {
        
            videoImage.image = UIImage(data: (videos?.vImageData)!)
        
        } else {
        
            videoImage.image = UIImage(named: "imageNotAvailable")
        
        }
    }


}
