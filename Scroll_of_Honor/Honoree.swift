//
//  Honoree.swift
//  Scroll_of_Honor
//
//  Created by John Lucas Garofalo on 11/23/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation

public enum Direction {
    case NE
    case NW
    case SW
    case SE
}

class HonoreeWat{

    
    var name: String!
    var hometown: String!
    var war: String!
    var rank: String!
    var service: String!
    var classYear: String!
    var quadrant: Direction!
    var picURL: String!
    
    init(name: String, hometown: String, war: String, rank: String, service: String, classyear: String, quadrant: Direction){
        self.name = name
        self.hometown = hometown
        self.war = war
        self.rank = rank
        self.service = service
        self.classYear = classyear
        self.quadrant = quadrant
    }
}