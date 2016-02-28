//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 28.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var labelListSize: UILabel!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelListSize.text = "\(Int(slider.value))"
    }

    @IBAction func changedSlider(sender: UISlider) {
        
        labelListSize.text = "\(Int(slider.value))"
        
    }
    
}
