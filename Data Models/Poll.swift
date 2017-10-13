//
//  Polls.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Poll: Post {
    //type = 1
    var timeLeft:Double?
    var option:[String]?
    var usersVoted:Set<Int>?
    var optionDistribution:Set<Int>?
    var numVotes:Int?
    
    init(id:Int,type:Int,time:Double,option:[String],distribution:Set<Int>,votes:Int) {
        super.init(id: id,b: type)
        self.timeLeft=time
        self.option = option
        self.optionDistribution = distribution
        self.numVotes = votes
    }
}
