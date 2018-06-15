//
//  GraphDataPoints.swift
//  DhyanaGenric
//
//  Created by Avantari on 12/26/17.
//  Copyright © 2017 AVANTARI. All rights reserved.
//

import Foundation

class GraphDataPoints {
    //MARK:- properties
    var mindfulness:Double
    var breathing:Double
    var relaxation:Double
    var sessionDate:String

    init(mindfulness: Double,breathing:Double,relaxation:Double,sessionDate:String) {
        self.mindfulness = mindfulness
        self.breathing = breathing
        self.relaxation = relaxation
        self.sessionDate = sessionDate
    }
}


