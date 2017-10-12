//
//  Polls.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class Poll: NSObject {
    var pollID:Int?
    var timeLeft:Double?
    var option:[String]?
    var usersVoted:Set<Int>?
    var optionDistribution:Set<Int>?
    var numVotes:Int?
    
    init(id:Int,time:Double,option:[String],distribution:Set<Int>,votes:Int) {
        self.pollID=id
        self.timeLeft=time
        self.option = option
        self.optionDistribution = distribution
        self.numVotes = votes
    }
}
