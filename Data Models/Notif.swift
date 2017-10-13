//
//  Notification.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/8/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Notif: NSObject {
    var action:String?
    var postName:String?
    var image:UIImage?
    
    init(image:UIImage, action:String, postName:String) {
        self.action = action
        self.image = image
        self.postName = postName
    }
}
