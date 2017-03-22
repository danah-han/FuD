//
//  RestaurantSignUp.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class RestaurantSignUp: UIViewController, UITextFieldDelegate {
    
    //Defining a function to display alerts if the sign up process is not completed properly
    func displayAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    //Creation of outlets for the fields a restaurant will fill out when signing up
    @IBOutlet var restaurantName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var town: UITextField!
    @IBOutlet var zipCode: UITextField!
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBAction func signUp(sender: AnyObject) {
        
        //Displays an alert if restaurant owner fails to fill in all fields
        if username.text == "" || password.text == "" || email.text == "" || restaurantName.text == "" {
            
            displayAlert("Missing Field(s)", message: "All fields are required.")
            
        }
            
        else {
            
            //If all fields are filled out, it will send the inputted strings to the backend
            let restaurantRole = PFRole(name: "restaurant")
            let user = PFUser()
            user["restaurantName"] = restaurantName.text
            user.email = email.text
            user.username = username.text
            user.password = password.text
            user["role"] = restaurantRole
            user["address"] = address.text
            user["town"] = town.text
            user["ZIPCode"] = zipCode.text
            
            //Displays an alert if the sign up fails
            user.signUpInBackgroundWithBlock {
                (succeded, error) -> Void in
                if let error = error {
                    if let errorString = error.userInfo["error"] as? String {
                        
                        self.displayAlert("Sign Up Failed", message: errorString)
                        
                    }
                    
                    
                } else {
                    restaurantRole.addUniqueObject(user, forKey: "users")
                    restaurantRole.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                    })
                    
                    print("Sign up Successful")
                    if let user = PFUser.currentUser() {
                        print(user.username)
                    }
                    self.performSegueWithIdentifier("restaurant_log_in", sender: nil)
                    
                }
                
            }
            
            
        }
        
        
    }
    
    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RestaurantSignUp.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RestaurantSignUp.keyboardWillDisappear), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillAppear(notification: NSNotification)
    {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.scrollBottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillDisappear()
    {
        
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.scrollBottomConstraint.constant = 0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        keyboardWillDisappear()
        textField.resignFirstResponder()
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
