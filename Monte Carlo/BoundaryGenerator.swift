//
//  BoundaryGenerator.swift
//  Monte Carlo
//
//  Created by apple on 06.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class BoundaryGenerator {
    
    static func findGrainBoundaries(forNeighbourhood neighbourhood:Neighbourhood, withPoints points: [[MCPoint]], lineSize: Int, andMeshSize meshSize: (height:Int, width:Int)) -> [[MCPoint]] {
        var points = points
        for i in 0..<meshSize.height {
            for j in 0..<meshSize.width {
                if !points[i][j].selected && points[i][j].id != 0 && !points[i][j].boundaryPoint {
                    var neighbours = neighbourhood.generateNeighbourhood(forMCPoints: points, i: i, j: j)
                }
            }
        }
        return points
    }
}
