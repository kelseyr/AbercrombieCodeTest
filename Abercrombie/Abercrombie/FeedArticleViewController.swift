//
//  FeedArticleViewController.swift
//  Abercrombie
//
//  Created by Kelsey Robertson on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import UIKit

class FeedArticleViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    var feedItem = FeedItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(feedItem.feedLink == nil){
            var constructionString = "<t>" + "\n" + "\n" + "\n"
            constructionString.appendContentsOf("\n" + (feedItem.feedTitle)!+"</t> \n")
            constructionString.appendContentsOf("<p>" + (feedItem.feedContent)! + "</p>")
            webView.loadHTMLString(constructionString, baseURL: nil)
        }else{
            let url = NSURL(string: feedItem.feedLink!)
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
