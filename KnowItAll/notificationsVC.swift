//
//  notificationsVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/7/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import SwiftyJSON

class notificationsVC: UITableViewController {
    //array to store all notifications
    var notifications:[Notif] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        notifications = getNotifications(user)
        loadNotificationsFromDB()
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
    
    func loadNotificationsFromDB() {
        let urlString = "/myNotifications?username=a@a.com"
        let json = getJSONFromURL(urlString)
        let pollIDs = json["pollID"]
        for notification in json["notifications"].arrayValue {
            let type = notification["type"].stringValue
            let text = notification["text"].stringValue
            let pollID = notification["pollID"].stringValue
            notifications.append(Notif.init(image: UIImage(named: "Food")!, action: text, postName: pollIDs[pollID].stringValue))
        }
        tableView.reloadData()
    }
}
