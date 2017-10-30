//
//  Polls.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Poll: Post {
    var option:[String]!
    var usersVoted:Set<Int>?
    var optionDistribution:Set<Int>?
    var numVotes:Int!
    var title:String!
    var category:Int!
    var timeLeft:Int!
    
    init(id:Int,type:Int,time:Int,option:[String],distribution:Set<Int>,votes:Int,text:String,cat:Int) {
        super.init(id: id,b: type)
        self.timeLeft = time
        self.option = option
        self.optionDistribution = distribution
        self.numVotes = votes
        self.title = text
        self.category = cat
    }
}
