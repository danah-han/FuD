//
//  RestaurantLogIn.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class RestaurantLogIn: UIViewController, UITextFieldDelegate {
    
    //Defining a function to display alerts if the log in process is not completed properly
    func displayAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    //Creation of outlets for the fields a restaurant will fill out when logging in 
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!

    @IBAction func login(sender: AnyObject) {
        
         //Displays an alert if restaurant owner fails to fill in the username and password fields
        if username.text == "" || password.text == "" {
        
            displayAlert("Missing Field(s)", message: "Both username and password are required.")
        
        } else {
            
            //Logs the user in as long as the username and password are correct
            PFUser.logInWithUsernameInBackground(username.text!, password:password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    
                    print("Login successful")
                    if let user = PFUser.currentUser() {
                        print(user.username)
                    }
                    self.performSegueWithIdentifier("log_in", sender: nil)
                    
                } else {
                
                    //Displays an error message if log in is unsuccessful
                    if let errorString = error?.userInfo["error"] as? String {
                        
                        self.displayAlert("Login Failed", message: errorString)
                        
                    }
                    
                }
        
    
            }
            
        }
        
    }
    
    
    @IBOutlet var loginbutton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

//Code to enable tap to dismiss keyboard. Currently in the comments because it is not properly working
        /*
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "Dismiss Keyboard")
        view.addGestureRecognizer(tap)
        
        self.username.delegate = self;
        self.password.delegate = self;
        */
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
  
    func textFieldShouldReturn(textField: UITextField) -> Bool{ //Deleted '!' next to UITextField - Aman
        
        username.resignFirstResponder()
        password.resignFirstResponder()
        return true
        
    }

    
//Function definition currently not in use
    /*
    func textFieldShouldReturn(textfield: UITextField) -> Bool {
    
        self.view.endEditing(true)
        return false
    }
    */
    
//Comment that came with the Parse Starter Project
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}


