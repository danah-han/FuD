//
//  RestaurantLogInViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 7/30/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class RestaurantLogInViewController: UIViewController {
    
    func displayAlert(title: String, message: String) {
        
       let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func logIn(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Missing Field(s)", message: "Username and password are required")
            
        } else {
            
            print("Signup Successful")
            
        }
        

    }
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func clickHere(sender: AnyObject) {
    }
    
    @IBOutlet weak var clickHereButton: UIButton!
    
    @IBAction func Back(sender: AnyObject) {
    }
    
    @IBOutlet weak var BackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
