//
//  BeaconTableViewCell.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit


class BeaconTableViewCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
  
    @IBOutlet var desc: UILabel!
   
    @IBOutlet var title: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0, height: 0)
        title.layer.shadowRadius = 6
        title.layer.shadowOpacity = 1
        
        // Configure the view for the selected state
    }
    
    
    
  
    

}
