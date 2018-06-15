//
//  GraphDataPoints.swift
//  RadarCharts
//
//  Created by malli nallapati on 24/05/18.
//  Copyright © 2018 malliswarinallapati. All rights reserved.
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


