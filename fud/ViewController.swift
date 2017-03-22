/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import BWWalkthrough

class ViewController: UIViewController, BWWalkthroughViewControllerDelegate
{
    
    var walkthrough:BWWalkthroughViewController!
    var token: dispatch_once_t = 0
    
    func startWalkthrough(){
        
        dispatch_once(&token)
        {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        self.walkthrough = stb.instantiateViewControllerWithIdentifier("container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("page_1") as UIViewController
        let page_two = stb.instantiateViewControllerWithIdentifier("page_2") as UIViewController
        let page_three = stb.instantiateViewControllerWithIdentifier("page_3") as UIViewController
        let page_four = stb.instantiateViewControllerWithIdentifier("page_4") as UIViewController
        let page_five = stb.instantiateViewControllerWithIdentifier("page_5") as UIViewController
        let page_six = stb.instantiateViewControllerWithIdentifier("page_6") as UIViewController
        let page_seven = stb.instantiateViewControllerWithIdentifier("page_7") as UIViewController
        
        // Attach the pages to the master
        self.walkthrough.delegate = self
        self.walkthrough.addViewController(page_one)
        self.walkthrough.addViewController(page_two)
        self.walkthrough.addViewController(page_three)
        self.walkthrough.addViewController(page_four)
        self.walkthrough.addViewController(page_five)
        self.walkthrough.addViewController(page_six)
        self.walkthrough.addViewController(page_seven)
        
        self.presentViewController(self.walkthrough, animated: true, completion: nil)
        }
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
            
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time. Start walkthrough")
            return false
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Section to do any additional setup after loading the view, typically from a nib.

    }
    override func viewDidAppear(animated: Bool)
    {
//        if isAppAlreadyLaunchedOnce() == true{
//            print("no walkthrough")
//            
//        } else {
//            print("walkthrough")
//            startWalkthrough()
//        }
    }
    func walkthroughCloseButtonPressed()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Section to dispose of any resources that can be recreated.
    }
}
