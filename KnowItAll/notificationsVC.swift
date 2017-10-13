//
//  notificationsVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/7/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class notificationsVC: UITableViewController {
    //array to store all notifications
    var notifications:[Notif] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        notifications = getNotifications(user)
        
    }
    
    func getNotification(user: User) -> [Notif] {
        let temp = [Notif]()
        
        return temp
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let curr = notifications[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell") as! NotificationCell
        cell.fill(n: curr)
        
        return cell
    }
}
