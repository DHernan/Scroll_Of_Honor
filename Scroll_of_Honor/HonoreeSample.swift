//
//  HonoreeSample.swift
//  Scroll_of_Honor
//
//  Created by John Lucas Garofalo on 11/23/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation

class HonoreeSample {
   
   var allHonorees = DatabaseService.sharedManager.getArray()
    func getMyHonorees(direction: String)->[Honoree] {
        var results = [Honoree]()
        for i in allHonorees {
            if (i.quad == direction){
                results.append(i)
            }
        }
        return results
    }
    
}