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
    var notifications = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        notification = getNotifications(user)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notifications[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //function used to direct after clicking a cell
    }
    
//    function to get array of notifications to be displayed
//    func getNotifications(User) -> Array<String> {
//
//    }

}
