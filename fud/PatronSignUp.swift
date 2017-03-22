//
//  PatronSignUp.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PatronSignUp: UIViewController, UITextFieldDelegate {

    func displayAlert(title: String, message: String){
        //Defining a function to display alerts if the sign up process is not completed properly
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    //Creation of outlets for the fields a user will fill out when signing up
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        
    //Displays an alert if a user fails to fill in all fields
        if username.text == "" || password.text == "" || email.text == "" {
            
            displayAlert("Missing Field(s)", message: "All fields are required.")
            
        }
            
        else {
            
        //If all fields are filled out, it will send the inputted strings to the backend
            let patronRole = PFRole(name: "patron")
            let user = PFUser()
            user.email = email.text
            user.username = username.text
            user.password = password.text
            user["patron"] = patronRole

            
            //Displays an alert if the sign up fails
            user.signUpInBackgroundWithBlock {
                (succeded, error) -> Void in
                if let error = error {
                    if let errorString = error.userInfo["error"] as? String {
                        
                        self.displayAlert("Sign Up Failed", message: errorString)
                        
                    }
                    
                    
                } else {
                    
                    patronRole.addUniqueObject(user, forKey: "patron_users")
                    patronRole.saveInBackgroundWithBlock({ (success, error) -> Void in
                    
                    })
                    
                    print("Sign up Successful")
                    self.performSegueWithIdentifier("patron_sign_up", sender: nil)
                    
                }
                
            }

        }
        
        
        
        
    }
    
    @IBOutlet var signUpButton: UIButton!
    
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
    
        email.resignFirstResponder()
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
