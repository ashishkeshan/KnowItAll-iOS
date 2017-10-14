//
//  BackendConnector.swift
//  KnowItAll
//
//  Created by Jonathon Shen on 10/13/17.
//  Copyright © 2017 Jonathon Shen. All rights reserved.
//

import Foundation
import SwiftyJSON

func getJSONFromURL(_ urlString: String, _ type: String) -> JSON {
    let url = "https://0a79ab09.ngrok.io/api" + urlString
    var json = JSON.null

    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = type

    let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
        if error != nil {
            print(error?.localizedDescription ?? "")
            return
        }
        json = JSON(data: data!)
        print(json)
    }
    task.resume()
    // Blocks until json is returned from http request
    while json == JSON.null {}
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
