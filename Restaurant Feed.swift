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


class Restaurant_Feed: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {
    
    @IBOutlet var feedTable: UITableView!     //Outlet for the feed of posts
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Section for any additional setup after loading the view.
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
            cell.dealName.text = dealName[indexPath.row]
            cell.startTime.text = startTime[indexPath.row]
            cell.endTime.text = endTime[indexPath.row]
            cell.details.text = details[indexPath.row]

            
            return cell
        }
    
    override func viewDidAppear(animated: Bool) {
        
        feedTable.reloadData()
        
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
