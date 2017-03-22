//
//  TestRestaurantFeed.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 9/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TestRestaurantFeed: PFQueryTableViewController {
    
    var dealName = [String]()
    var details = [String]()
    var startTime = [String]()
    var endTime = [String]()
    
    @IBOutlet var feedTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dealName.count
    }
    
    
    override func tableView(tableView: UITableView/*!*/, cellForRowAtIndexPath indexPath: NSIndexPath/*!*/) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        cell.dealName.text = dealName[indexPath.row]
        cell.startTime.text = startTime[indexPath.row]
        cell.endTime.text = endTime[indexPath.row]
        cell.details.text = details[indexPath.row]
        
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        
        feedTable.reloadData()
        
    }
    
    override func queryForTable() -> PFQuery {
        
        let query = PFQuery(className: RestaurantPost)
        query.cachePolicy = .CacheElseNetwork
        query.orderByDescending("createdAt")
        return query
    }

    override func tableView(tableView: UITableView, cellForNextPageAtIndexPath indexPath: NSIndexPath) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestCell
        
        cell.dealName.text = object?.objectForKey("dealTitle") as? String
        cell.details.text = object?.objectForKey("dealDescription") as? String
        cell.startTime.text = object?.objectForKey("startTime") as? String
        cell.endTime.text = object?.objectForKey("endTime") as? String
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row + 1 > self.objects?.count
        {
            return 44
        }
        
        let height = super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        return height
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row + 1 > self.objects?.count
        {
            self.loadNextPage()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        else
        {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
    
        
        
    }
    
}
