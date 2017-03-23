//
//  BeaconsCell.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 24/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import Foundation


import UIKit

class BeaconsCell : UITableViewCell {
    
//    @IBOutlet weak var gameLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var ratingImageView: UIImageView!
    
    var beacons: Beacons! {
        didSet {
            gameLabel.text = beacons.game
            nameLabel.text = beacons.name
            ratingImageView.image = imageForRating(rating: beacons.rating)
        }
    }
    
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    
    
}
