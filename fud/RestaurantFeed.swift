//
//  Restaurant Feed.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse                    //Backend is set up using back4app.com, which is a BaaS that based off of Parse; back4app was
                                //created as an alternative now that Parse is closing down
import ParseUI                  //Requires the download of the ParseUI CocoaPod

//Creating variables for the strings stored on the Parse/back4app backend
var dealName = [String]()       //Title of the deal
var details = [String]()        //Deal description
var startTime = [String]()
var endTime = [String]()
var restaurantName = [String]()
var streets = [String]()
var towns = [String]()
var profilePicture = [PFFile?]()

class Restaurant_Feed: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {
    
    @IBOutlet var feedTable: UITableView!     //Outlet for the feed of posts
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Section for any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(animated: Bool) {        
        
        let query = PFQuery(className: "RestaurantPost")
        query.addDescendingOrder("createdAt")
        let date = NSDate(timeIntervalSinceNow: -60*60*24) //number of seconds
        query.whereKey("createdAt", greaterThanOrEqualTo: date)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                    
                    dealName.removeAll()
                    details.removeAll()
                    startTime.removeAll()
                    endTime.removeAll()
                    profilePicture.removeAll()
                    streets.removeAll()
                    towns.removeAll()
                    restaurantName.removeAll()
                for object in objects{
                    
                    if getEndDateFromObject(object).compare(NSDate()) == NSComparisonResult.OrderedAscending {
                        
                        continue    //moves past this section of the for loop
                        
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
            
                self.feedTable.reloadData()
            
                
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
        print("\(streets[indexPath.row]), \(towns[indexPath.row])")
        cell.address.text =  "\(streets[indexPath.row]), \(towns[indexPath.row])"
        
        let file = profilePicture[indexPath.row]
        file?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            if let data = data where error == nil{
                let image = UIImage(data: data)
                cell.profilePicture.image = image
            }
        })
        
        return cell
    }
    

//Comment that came with the Parse Starter Project
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
