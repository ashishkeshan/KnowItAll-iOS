//
//  Review.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Review: NSObject {
    var reviewID:Int?
    var rating:Double?
    var comment:String?
    
    init(id:Int,rating:Double,comment:String) {
        self.reviewID=id
        self.rating=rating
        self.comment=comment
    }
}
