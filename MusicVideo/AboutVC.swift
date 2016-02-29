//
//  AboutVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 29.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var creatorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)

        }

    func preferredFontChanged(){
       descriptionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
       creatorLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }

}
