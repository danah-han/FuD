//
//  HelperFunctions.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 12/10/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import Parse

func getEndDateFromObject(object: PFObject) -> NSDate {
    
    let endString = object["endTime"] as! String
    var creationDate = object.createdAt!
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Day, NSCalendarUnit.Era], fromDate: creationDate)   //extracts month, year, day and era from the string. can add more info to it like hours
    
    if endString == "Noon"{
        
        components.hour = 12
    
    } else if endString == "Midnight"{
        
        components.hour = 0
        components.day = components.day + 1
    
    } else {
        
        var intString = endString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        
        let int = Int(intString)    //extracts integers from string and converts to integer; for getting the time value
        
        if endString.containsString("AM"){
            
            components.hour = int!
    
        } else {
            
            let PMTime = int! + 12
            components.hour = PMTime
            
        }
    }
    
    return calendar.dateFromComponents(components)!
}