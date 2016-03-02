//
//  FeedTableViewController.swift
//  Abercrombie
//
//  Created by Kelsey Robertson on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, FeedParserDelegate {
    
    var feedItems = [FeedItem]()
    var selectedIndex = 0
    
    enum VendingMachineError: ErrorType {
        case InvalidSelection
        case InsufficientFunds(coinsNeeded: Int)
        case OutOfStock
    }
    
    
    func request(){
        let url = "http://news.google.com/news?cf=all&hl=en&pz=1&ned=us&output=rss"
        var feedParser: FeedParser?
        
        feedParser = FeedParser(feedURL: url)
        feedParser?.delegate = self
        feedParser?.parse()
    }
    
    func feedParserDidStart(parser: FeedParser!) {
        feedItems = [FeedItem]()
    }
    
    func feedParserDidFinish(parser: FeedParser!) {
        self.tableView.reloadData()
    }
    
    func feedParser(parser: FeedParser, didParseChannel channel: FeedChannel) {
        self.title = channel.channelTitle
    }
    
    func feedParser(parser: FeedParser, didParseItem item: FeedItem) {
        feedItems.append(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        request()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func parsingOutImage(row: Int) ->String{
        let item = feedItems[row] as FeedItem
        let content = item.feedContent
        
        let range: Range<String.Index> = content!.rangeOfString("<img src=\"")!
        let range2: Range<String.Index> = content!.rangeOfString("\" alt=")!
        
        let trueImageString = content![range.endIndex.advancedBy(2)...range2.startIndex.predecessor()]
        
        return "http://" + trueImageString
        
    }
    
    func parsingOutContentSnippet(row: Int) ->String{
        let item = feedItems[row] as FeedItem
        let content = item.feedContent
        
        let range: Range<String.Index> = content!.rangeOfString("</font></b></font><br><font size=\"-1\">")!
        let range2: Range<String.Index> = content!.rangeOfString("&nbsp;")!
        
        let contentSnippet = content![range.endIndex...range2.startIndex]
        
        return contentSnippet
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! FeedCell
        
        let item = feedItems[indexPath.row] as FeedItem
        
        cell.feedTitleLabel.text = item.feedTitle
        
        var contentSnippet = parsingOutContentSnippet(indexPath.row)
        
        cell.subTitleLabel.text = contentSnippet
        
        let imageString = parsingOutImage(indexPath.row)
        let imageURL = NSURL(string: imageString)
        var imageData = NSData()
        
        do{
            imageData = try NSData(contentsOfURL: imageURL!, options:NSDataReadingOptions.DataReadingUncached)
        }
        catch{
            print(error)
            imageData = NSData(data: UIImagePNGRepresentation(UIImage(imageLiteral: "rss.png"))!)

            //TODO: set imageData to the rss picture
        }
        
        let tempImage =  UIImage(data: imageData)
        
        cell.feedImage.image = tempImage
        
        
        return cell
    }
    
    
//MARK: Segues
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        selectedIndex = indexPath.row
        performSegueWithIdentifier("showArticle", sender: self)
    
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showArticle"){
            
            let destViewController : FeedArticleViewController = segue.destinationViewController as! FeedArticleViewController
            
            destViewController.feedItem = feedItems[selectedIndex] as FeedItem

            
        }
        
    }
}






















