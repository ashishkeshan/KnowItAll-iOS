//
//  NotificationCell.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/8/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var notificationPost: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationAction: UILabel!
    
    func fill(n: Notif)  {
        notificationPost.text = n.postName
        notificationImage.image = n.image
        notificationAction.text = n.action
    }
}
