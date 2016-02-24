//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Sergey Guznin on 24.02.16.
//  Copyright © 2016 Sergey Guznin. All rights reserved.
//

import Foundation

class Videos{
    
    //Data Encapsulation
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String

    //Make a getter
    
    var vName: String {
    
        return _vName
    
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
        
        //The video image
        
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictioanry,
        _image = image["label"] as? String
        {
            
            self._vImageUrl = _image.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
            
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
    
    
    
    }

}
