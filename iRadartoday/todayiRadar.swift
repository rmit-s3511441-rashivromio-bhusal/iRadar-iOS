//
//  todayiRadar.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 17/5/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import Foundation


class todayiRadar {
    
    var iRadar = [
        "Check the special discount today when visiting Melton Supps ", "Check the special discount today when visiting Melton Supps  ","Check the special discount today when visiting Melton Supps " 
    ]
    
    func randomiRadar() ->String{
        return iRadar[ Int(arc4random_uniform(UInt32(iRadar.count)))]
    }
    
    
}
