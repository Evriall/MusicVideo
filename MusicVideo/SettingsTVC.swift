//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 28.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    @IBOutlet weak var aboutDisplay: UILabel!

    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var labelListSize: UILabel!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        labelListSize.text = "\(Int(slider.value))"
    }

    @IBAction func bestImageChanged(sender: UISwitch) {
    }
    @IBAction func changedSlider(sender: UISlider) {
        
        labelListSize.text = "\(Int(slider.value))"
        
    }
    
    @IBAction func touchIdChanged(sender: UISwitch) {
    }
    
    func preferredFontChanged(){
    
        labelListSize.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }
    
    
}
