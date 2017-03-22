//
//  ClosingSoon.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 11/8/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseUI

class ClosingSoonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet var closingSoon: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Section for any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "RestaurantPost")
        query.addAscendingOrder("createdAt")
        let date = NSDate(timeIntervalSinceNow: -60*60*24) //number of seconds; can't be greater than 24 hours
        
//        var startDate = NSDate(timeIntervalSinceNow: -60*60*) //can't be less than (make it 5 hours until there are more posts)
        
        query.whereKey("createdAt", greaterThanOrEqualTo: date)
//        query.whereKey("createdAt", lessThanOrEqualTo: startDate)
        query.limit = 10 //limits the number of objects you can get...by default should be around 100
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                dealName.removeAll()
                details.removeAll()
                startTime.removeAll()
                endTime.removeAll()
                profilePicture.removeAll()
                
                objects.sort({ (object1, object2) -> Bool in
                    return getEndDateFromObject(object1).compare(getEndDateFromObject(object2)) == NSComparisonResult.OrderedAscending
                })
                
                for object in objects{
                    
                    let endDate = getEndDateFromObject(object)
                    
                    //checks to see if end date is after now, but also has to be before an hour from now
                    //if one of these conditions is satisified, it isn't added to the closing soon feed
                    if  endDate.compare(NSDate()) == NSComparisonResult.OrderedAscending || endDate.compare(NSDate(timeIntervalSinceNow: 60*60)) == NSComparisonResult.OrderedDescending {
                        
                        continue    //goes back to top of the for loop with the next object
                        
                    }
                    
                    restaurantName.append(object["restaurantName"] as! String)
                    if object["street"] != nil
                    {
                        streets.append(object["street"] as! String)
                    }
                    else
                    {
                        streets.append(" ")
                    }
                    if object["town"] != nil
                    {
                        towns.append(object["town"] as! String)
                    }
                    else
                    {
                        towns.append(" ")
                    }
                    dealName.append(object["dealTitle"] as! String)
                    details.append(object["dealDescription"] as! String)
                    startTime.append(object["startTime"] as! String)
                    endTime.append(object["endTime"] as! String)
                    profilePicture.append(object["profilePicture"] as? PFFile)
                }
                
                self.closingSoon.reloadData()
                
            }else{
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dealName.count
    }
    
    //Sends the strings (inputs by the restaurant user for their new post) from the backend to the feed of posts
    func tableView(tableView: UITableView/*!*/, cellForRowAtIndexPath indexPath: NSIndexPath/*!*/) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        //Appends the appropriate strings to the correct placement in the cell
        cell.restaurantName.text = restaurantName[indexPath.row]
        cell.dealName.text = dealName[indexPath.row]
        cell.times.text = "\(startTime[indexPath.row]) to \(endTime[indexPath.row])"
        cell.details.text = details[indexPath.row]
        cell.address.text = "\(streets[indexPath.row]), \(towns[indexPath.row])"
        
        let file = profilePicture[indexPath.row]
        file?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            if let data = data where error == nil{
                let image = UIImage(data: data)
                cell.profilePicture.image = image
            }
        })

        
        
        return cell
    }
    


}