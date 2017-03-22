//
//  CustomCell.swift
//  ParseStarterProject-Swift
//
//  Created by Danah Han on 8/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

//Creation of outlets for the locations of the strings a restaurant enters when making a new post
    @IBOutlet var dealName: UILabel!
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var times: UILabel!
    @IBOutlet var details: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var address : UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Section to configure the view for the selected state
    }

}
