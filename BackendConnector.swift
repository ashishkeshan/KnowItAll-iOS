//
//  BackendConnector.swift
//  KnowItAll
//
//  Created by Jonathon Shen on 10/13/17.
//  Copyright © 2017 Jonathon Shen. All rights reserved.
//

import Foundation
import SwiftyJSON
//var host = "https://0a79ab09.ngrok.io/api"
//var host = "https://4f3fe20d.ngrok.io/api"
var host = "http://knowitalllive-dev.us-west-1.elasticbeanstalk.com/api"

func getJSONFromURL(_ urlString: String, _ type: String) -> JSON {
    var url = host + urlString
    url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    var json = JSON.null
    var queryFinished = false

    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = type
    
    let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
        if error != nil {
            print(error?.localizedDescription ?? "")
            return
        }
        json = JSON(data: data!)
        print(json)
        queryFinished = true
    }
    task.resume()
    // Blocks until a query is returned from http request
    while queryFinished == false {}
    return json
}

//func getJSONFromURL(_ urlString: String, _ type: String) -> JSON {
//    let url = NSURL(string: "https://0a79ab09.ngrok.io/api" + urlString)
//    var json = JSON.null
//
//    URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
//        json = JSON(data: data!)
//        print(json)
//    }).resume()
//    // Blocks until json is returned from http request
//    while json == JSON.null {}
//    return json
//}
//
