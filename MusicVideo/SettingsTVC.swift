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

    @IBOutlet weak var bestImageSwitch: UISwitch!
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
        touchId.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        bestImageSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("BestImageQuality")
        if let APICnt = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as? Int {
            slider.value = Float(APICnt)
            labelListSize.text = "\(APICnt)"
        } else {
        
            labelListSize.text = "\(Int(slider.value))"
        
        }
        title = "Settings"
    }

    @IBAction func bestImageChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if bestImageSwitch.on {
            
            defaults.setBool(bestImageSwitch.on, forKey: "BestImageQuality")
            
        } else {
            
            defaults.setBool(false, forKey: "BestImageQuality")
            
        }
    }
    @IBAction func changedSlider(sender: UISlider) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(slider.value), forKey: "APICNT")
        
        labelListSize.text = "\(Int(slider.value))"
        
    }
    
    @IBAction func touchIdChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchId.on {
        
            defaults.setBool(touchId.on, forKey: "SecSetting")
        
        } else {
        
            defaults.setBool(false, forKey: "SecSetting")
        
        }
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
