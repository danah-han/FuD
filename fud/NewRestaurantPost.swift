//
//  New Restaurant Post.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class New_Restaurant_Post: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Creation of outlets for the fields a restaurant will use when making a new post
    @IBOutlet var dealTitle: UITextField!
    @IBOutlet var dealDescription: UITextView!
    
    @IBOutlet var endTimePicker: UIPickerView!
    @IBOutlet var startTimePicker: UIPickerView!
    
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    
    var userSelectionStartTime = 24
    var userSelectionEndTime = 24
    
    var timesArray = ["Noon", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM", "Midnight", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM"]
    
    func displayAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func confirmationAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes, Continue", style: UIAlertActionStyle.Default, handler: self.makePost))
        alert.addAction(UIAlertAction(title: "No, Cancel", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func post(sender: AnyObject) {
        
        if dealTitle.text == "" || dealDescription.text == "" || startTimeLabel.text == "" || endTimeLabel.text == "" {
            
            displayAlert("Missing Field(s)", message: "All fields are required.")
            
        } else {
            
            confirmationAlert("Confirm Accuracy", message: "Are you certain this deal post contains the correct information?")
            
        }
        
        
        //Takes information inputted/assigned to the above variables and sends them to the backend once the "post" button is pressed
        
    }
    
    func makePost(action: UIAlertAction){
        
        let post = PFObject(className: "RestaurantPost")
        
        //post["profilePicture"] = PFUser.currentUser()?["profilePicture"]
        post["restaurantName"] = PFUser.currentUser()?["restaurantName"]
        print(PFUser.currentUser()?["restaurantName"])
        if PFUser.currentUser()?["address"] != nil
        {
            post["street"] = PFUser.currentUser()?["address"]
        }
        else
        {
            post["street"] = " "
        }
        if PFUser.currentUser()?["town"] != nil
        {
            post["town"] = PFUser.currentUser()?["town"]
        }
        else
        {
            post["town"] = " "
        }
        
        post["dealTitle"] = dealTitle.text
        post["dealDescription"] = dealDescription.text
        post["startTime"] = startTimeLabel.text
        post["endTime"] = endTimeLabel.text
        
        post.saveInBackgroundWithBlock{(success, error) -> Void in
            
            if success{
                
                self.tabBarController?.selectedIndex = 0
                self.dealTitle.text = nil
                self.dealDescription.text = nil
                self.startTimeLabel.text = nil
                self.endTimeLabel.text = nil
                self.startTimePicker.selectRow(0, inComponent: 0, animated: false)
                self.endTimePicker.selectRow(0, inComponent: 0, animated: false)
                
                self.performSegueWithIdentifier("post", sender: nil)
                
            } //display error if otherwise
            
        }
        
    }
    
    @IBOutlet var postButton: UIButton!
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timesArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timesArray.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startTimePicker{
            startTimeLabel.text = timesArray[row]
        }
        
        if pickerView == endTimePicker {
            endTimeLabel.text = timesArray[row]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimePicker.delegate = self
        startTimePicker.dataSource = self
        endTimePicker.delegate = self
        endTimePicker.dataSource = self
        
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
