//
//  BoundaryGenerator.swift
//  Monte Carlo
//
//  Created by apple on 06.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class BoundaryGenerator {
    
    static func findGrainBoundaries(forNeighbourhood neighbourhood:Neighbourhood, withPoints points: [[MCPoint]]) -> [[MCPoint]] {
        let meshSize = (height: points.count, width: points[0].count)
        var points = points
        for i in 0..<meshSize.height {
            for j in 0..<meshSize.width {
                if !points[i][j].selected && points[i][j].id != 0 && !points[i][j].boundaryPoint {
                    for row in neighbourhood.generateNeighbourhood(forMCPoints: points, i: i, j: j) {
                        for neighbour in row {
                            if !neighbour.selected && neighbour.id != points[i][j].id {
                                points[i][j].boundaryPoint = true
                            }
                        }
                    }
                }
            }
        }
        return points
    }
}
