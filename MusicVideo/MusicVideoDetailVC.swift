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
import LocalAuthentication

class MusicVideoDetailVC: UIViewController{

    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var videos: Videos!
    var securitySwitch: Bool = false
    
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
    
 
    @IBAction func sicialMedia(sender: UIBarButtonItem) {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true:
            touchIDCheck()
        default:
            shareMedia()
        }
        
        
    }
    func shareMedia(){
    
        let activity1 = "Have you had the oportunity to see this music Video?"
        let activity2 = "\(videos.vName) by \(videos.vArtist)"
        
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "Shared with the Music Video App - Step it UP!"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if  activity == UIActivityTypeMail {

                print("Email selected")

            }

        }
         self.presentViewController(activityViewController, animated: true, completion: nil)
        
    
    }
    
    func touchIDCheck(){
    
    
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .Cancel, handler: nil))
        
        let context = LAContext()
        var touchIDError : NSError?
        let reasonString = "Touch-id authentication is needed to share info on Social Media"
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
  
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, policyError) -> Void in

                if success {
                
                    dispatch_async(dispatch_get_main_queue()) {
                        [unowned self] in self.shareMedia()
                    }
                
                
                } else {
                
                    
                    alert.title = "Unsuccessful!"
                    switch LAError(rawValue: policyError!.code)! {
                    
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by application"
                    case .UserCancel:
                        alert.message = "You cancelled the request"
                    case .TouchIDLockout:
                        alert.message = "Too many faild attempts"
                    case .AuthenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on the device"
                    case .SystemCancel:
                        alert.message = "Authentication was cancelled by the system"
                    case .UserFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                    default:
                        alert.message = "Unable to Authenticate!"
                    
                    }
                
                    dispatch_async(dispatch_get_main_queue()) {
                    
                    [unowned self] in self.presentViewController(alert, animated: true, completion: nil)
                        
                    
                    }
                }

            })

        } else {
        
            alert.title = "Error"
            
            switch LAError(rawValue: touchIDError!.code)! {
            
            case .InvalidContext:
                alert.message = "The context is invalid"
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
            case .TouchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
            case .TouchIDNotEnrolled:
                alert.message = "TouchID is not enrolled"
            default:
                alert.message = "Local Authentication not available"
                
            
            }
            dispatch_async(dispatch_get_main_queue()) {
                
                [unowned self] in self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
        
        }
    
    }

    
    deinit{
       
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
    }


}
