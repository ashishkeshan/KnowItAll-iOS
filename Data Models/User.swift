//
//  User.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class User: NSObject {
    var email: String?
    
    init(_ email: String) {
        super.init()
        self.email = email
    }
}
