//
//  Topic.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Topic: NSObject {
    var numReviews:Int!
    var title:String!
    var rating:Double!
    var category:Int!
    
    init(votes: Int, title: String, rating: Double, cat: Int) {
        self.numReviews = votes
        self.title = title
        self.rating = rating
        self.category = cat
    }
    
}
