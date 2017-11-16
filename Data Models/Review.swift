//
//  Review.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Review: Post {
    var rating:Double!
    var comment:String!
    var topic:String!
    var anonymous:Int?
    
    init(id:Int,type:Int,rating:Double,comment:String,text:String) {
        super.init(id: id,b: type)
        self.rating=rating
        self.comment=comment
        self.topic = text
    }
}
