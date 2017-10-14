//
//  Post.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Post: NSObject {
    var id:Int?
    var t:type?
    enum type {
        case Review
        case Poll
    }
    
    init(id:Int,b:Int) {
        self.id = id
        if(b == 1) {
            t = type.Review
        }
        else {
            t = type.Poll
        }
    }
}
