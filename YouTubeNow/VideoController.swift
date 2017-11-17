//
//  VideoController.swift
//  We Watch
//
//  Created by elva wang on 11/15/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import Foundation
import UIKit

class VideoController: UIViewController {
    
    @IBOutlet weak var myVideo: UIWebView!
    
    var likes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testing.text = "xxxx"
        getVideo()
        print("This is the likes: \(likes)")
    }
    
    func getVideo(){
        print("The likes is this: \(likes)")
        let url = URL(string: "https://www.youtube.com/playlist?list=\(String(describing: likes))")
        myVideo.loadRequest(URLRequest(url:url!))
    }


    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    func performGetRequest(targetURL: NSURL!, completion: @escaping (_ data: NSData?, _ HTTPStatusCode: Int, _ error: NSError?) -> Void) {
//        let request = NSMutableURLRequest(url: targetURL as URL)
//        request.httpMethod = "GET"
//
//        let sessionConfiguration = URLSessionConfiguration.default
//
//        let session = URLSession(configuration: sessionConfiguration)
//
//        let task = session.dataTaskWithRequest(request as URLRequest, completionHandler: { (data: NSData!, response: URLResponse!, error: NSError!) -> Void in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                completion(data as! NSData, (response as! HTTPURLResponse).statusCode, error as! NSError)
//            })
//        })
//
//        task.resume()
//    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    
}












//
