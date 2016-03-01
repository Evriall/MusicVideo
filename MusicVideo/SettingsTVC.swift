//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 28.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate  {
    @IBOutlet weak var aboutDisplay: UILabel!

    @IBOutlet weak var bestImageSwitch: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var labelListSize: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var descriptionNumberOfMusivVideo: UILabel!
    
    @IBOutlet weak var footnoteLabel: UILabel!
    
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
        descriptionNumberOfMusivVideo.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        footnoteLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
        
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
            
                
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            
            } else {
            
            
                mailAlert()
            
            }
        
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        }
    }
    
    func configureMail() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["test@gmail.com"])
        mailComposeVC.setSubject("Music Video App FeedBack")
        mailComposeVC.setMessageBody("Hi Evrial, \n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC

    }
    
    func mailAlert() {
    
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No email Acoount setup for phone", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
    
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        default:
            print("Other issue")
        
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }
    
    
}
