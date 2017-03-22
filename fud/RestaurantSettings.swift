//
//  Partners.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 11/8/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

class RestaurantSettings: UIViewController {
    
    @IBAction func websiteButton(sender: UIButton) {
        
        if let url = NSURL(string: "http://www.fudinc.com"){
            UIApplication.sharedApplication().openURL(url)
        }

    }
    
    @IBAction func logOut(sender: UIButton) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil{
                if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
                    let stb = UIStoryboard(name: "Main", bundle: nil)
                    delegate.window?.rootViewController = stb.instantiateInitialViewController()
                }
            } //add an error message for user in future
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Section for any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
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
