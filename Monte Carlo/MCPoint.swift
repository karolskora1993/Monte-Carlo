//
//  MCPoint.swift
//  Monte Carlo
//
//  Created by apple on 26.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

struct MCPoint {
    var id:Int
    var phase = 0
    var x:Int
    var y:Int
    var selected = false
    var chosen = false
    
    init(withID id:Int, x:Int, y:Int) {
        self.id = id
        self.x = x
        self.y = y
    }
    
    init() {
        self.init(withID: 0, x: 0, y: 0)
    }
    
    static func clearChosen(forMCPoints points: [[MCPoint]]) -> [[MCPoint]] {
        var temp_points = points
        for i in 0..<points.count {
            for j in 0..<points[0].count {
                temp_points[i][j].chosen = false
            }
        }
        return temp_points
    }
    
    static func clearPoints(forMCPoints points: [[MCPoint]]) -> [[MCPoint]] {
        var temp_points = points
        for i in 0..<points.count {
            for j in 0..<points[0].count {
                temp_points[i][j].chosen = false
                temp_points[i][j].selected = false
                temp_points[i][j].id = 0
            }
        }
        return temp_points
    }
    
    static func chechForNotDrawnElements(forPoints points:[[MCPoint]]) ->Bool {
        for row in points {
            for element in row {
                if !element.selected && !element.chosen  {
                    return true
                }
            }
        }
        return false
    }
    
}
