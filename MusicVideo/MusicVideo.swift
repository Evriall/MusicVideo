//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import Foundation

class Videos{
    
    var vRank = 0
    
    //Data Encapsulation
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    private var _vPrice: String
    private var _vRights: String
    private var _vArtist: String
    private var _vImid: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDate: String
    
    var vImageData: NSData?
    //Make a getter
    
    var vName: String {
    
        return _vName
    
    }
    
    var vGenre: String {
        
        return _vGenre
        
    }
    
    var vLinkToiTunes: String {
        
        return _vLinkToiTunes
        
    }
    
    var vReleaseDate: String {
        
        return _vReleaseDate
        
    }
    
    var vPrice: String {
        
        return _vPrice
        
    }
    var vRights: String {
        
        return _vRights
        
    }
    var vArtist: String {
        
        return _vArtist
        
    }
    var vImid: String {
        
        return _vImid
        
    }
    var vImageUrl: String {
    
        return _vImageUrl
    
    }
    
    var vVideoUrl: String {
        
        return _vVideoUrl
        
    }
    
    init(data: JSONDictioanry) {
    
        //Video name
        
        if let name = data["im:name"] as? JSONDictioanry, vName = name["label"] as? String {
        
            self._vName = vName
        
        } else {
        
            self._vName = ""
        
        }
        
        
        //Price
        
        if let price = data["im:price"] as? JSONDictioanry, vPrice = price["label"] as? String {
            
                self._vPrice = vPrice
            
            } else {
            
                self._vPrice = ""
            
            }
        
        //Rights
        
        if let rights = data["rights"] as? JSONDictioanry, vRights = rights["label"] as? String {
            
            self._vRights = vRights
            
        } else {
            
            self._vRights = ""
            
        }
        
        //Artist
        
        if let artist = data["im:artist"] as? JSONDictioanry, vArtist = artist["label"] as? String {
            
            self._vArtist = vArtist
            
        } else {
            
            self._vArtist = ""
            
        }
        
        
    
        //The video image
        
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictioanry,
        _image = image["label"] as? String
        {
            
            let imageQuality = NSUserDefaults.standardUserDefaults().boolForKey("BestImageQuality")
           
            if (imageQuality && reachabilityStatus == WIFI) {
                self._vImageUrl = _image.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
            } else {
                 self._vImageUrl = _image.stringByReplacingOccurrencesOfString("100x100", withString: "200x200")
            }
            

        } else {
            
            self._vImageUrl = ""
            
        }
        
        //Video URL
        
        if let video  = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictioanry,
            vHref = vUrl["attributes"] as? JSONDictioanry,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
            }
          else {
            
            self._vVideoUrl = ""
            
        }
        
        //Video genre
        
        if let genre  = data["category"] as? JSONDictioanry,
            vAttr = genre["attributes"] as? JSONDictioanry,
            vGenre = vAttr["term"] as? String {
                self._vGenre = vGenre
        }
        else {
            
            self._vGenre = ""
            
        }
        
        if let releaseDate  = data["im:releaseDate"] as? JSONDictioanry,
            vAttrRD = releaseDate["attributes"] as? JSONDictioanry,
            vReleaseDate = vAttrRD["label"] as? String {
                self._vReleaseDate = vReleaseDate
        }
        else {
            
            self._vReleaseDate = ""
            
        }
        
        //Im id
        
        if let imid  = data["id"] as? JSONDictioanry,
            vAttrID = imid["attributes"] as? JSONDictioanry,
            vImid = vAttrID["im:id"] as? String {
            
            self._vImid = vImid
            
        } else {
            
            self._vImid = ""
            
        }
        
        //iTunes Link
        
        if let linkToiTunes  = data["id"] as? JSONDictioanry,
            vLinkToiTunes = linkToiTunes["label"] as? String {
                
                self._vLinkToiTunes = vLinkToiTunes
                
        } else {
            
            self._vLinkToiTunes = ""
            
        }
    
    }

}
