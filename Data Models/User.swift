//
//  User.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class User: NSObject {
    var userID: Int?
    var email: String?
    var myPolls: [Poll]?
    var myReviews: [Review]?
    
    init(id: Int, email: String) {
        super.init()
        self.userID = id
        self.email = email
        
        self.myPolls = loadPolls(email: email)
        self.myReviews = loadReview(email: email)
    }
    
    func loadPolls(email:String) -> [Poll] {
        var polls = [Poll]()
        
        //TODO
        
        return polls
    }
    
    func loadReview(email:String) -> [Review] {
        var polls = [Review]()
        
        //TODO
        
        return polls
    }
}
