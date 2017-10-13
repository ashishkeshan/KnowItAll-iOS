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
    
    init(id: Int, email: String) {
        super.init()
        self.userID = id
        self.email = email
    }
}
