//
//  PatronLogIn.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PatronLogIn: UIViewController,UITextFieldDelegate {
    
    //Defining a function to display alerts if the log in process is not completed properly
    func displayAlert(title: String, message: String){
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    //Creation of outlets for the fields a user will fill out when logging in 
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func logIn(sender: AnyObject) {
        
        //Displays an alert if user fails to fill in the username and password fields
        if username.text == "" || password.text == "" {
            
            displayAlert("Missing Field(s)", message: "Both username and password are required.")
            
        } else {
            
            //Logs the user in as long as the username and password are correct
            
            
            
            
            
            PFUser.logInWithUsernameInBackground(username.text!, password:password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    
                    print("Login successful")
//                    let prefs = NSUserDefaults.standardUserDefaults()
//                    prefs.setObject(user, forKey: "User")
//                    prefs.synchronize()
                    self.performSegueWithIdentifier("patron_log_in", sender: nil)
                    
                } else {
                    
                    //Displays an error message if log in is unsuccessful
                    if let errorString = error?.userInfo["error"] as? String {
                        
                        self.displayAlert("Login Failed", message: errorString)
                        
                    }
                    
                }
                
            }
            
        }

    }
    
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Section to do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        username.resignFirstResponder()
        password.resignFirstResponder()
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
