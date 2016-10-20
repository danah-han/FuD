//
//  New Restaurant Post.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class New_Restaurant_Post: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {

    //Creation of outlets for the fields a restaurant will use when making a new post
    @IBOutlet var dealTitle: UITextField!
    @IBOutlet var dealDescription: UITextField!
    @IBOutlet var dealStartTime: UITextField!
    @IBOutlet var dealEndTime: UITextField!
    
    @IBAction func post(sender: AnyObject) {
        
        //Takes information inputted/assigned to the above variables and sends them to the backend once the "post" button is pressed
        let post = PFObject(className: "RestaurantPost")
        post["restaurantName"] = PFUser.currentUser()!.objectId!
        post["dealTitle"] = dealTitle.text
        post["dealDescription"] = dealDescription.text
        post["startTime"] = dealStartTime.text
        post["endTime"] = dealEndTime.text
        
        post.saveInBackgroundWithBlock{(success, error) -> Void in
        
        }

    }
    
    @IBOutlet var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Section for any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
    
        dealTitle.resignFirstResponder()
        dealDescription.resignFirstResponder()
        dealStartTime.resignFirstResponder()
        dealEndTime.resignFirstResponder()
        return true
    
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
