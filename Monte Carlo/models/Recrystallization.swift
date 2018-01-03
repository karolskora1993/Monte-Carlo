//
//  Recrystallization.swift
//  Monte Carlo
//
//  Created by apple on 15.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation


class Recrystallization {
    
    static func distribute(forPoints points:[[MCPoint]], neighbourhood:Neighbourhood, internalEnergy:Int, andBoundaryEnergy boundEnergy:Int) -> [[MCPoint]] {
        var points = BoundaryGenerator.findGrainBoundaries(forNeighbourhood: neighbourhood, withPoints: points)
        let meshSize = (height: points.count, width: points[0].count)
        for i in 0..<meshSize.height {
            for j in 0..<meshSize.width {
                if !points[i][j].selected {
                    points[i][j].energy = points[i][j].boundaryPoint ? boundEnergy : internalEnergy
                }
            }
        }
        return points
    }
    
    static func nextStep(forPoints points: [[MCPoint]], andNucleationType nucleationType: Nucleationtype) -> [[MCPoint]] {
        //MARK: TODO
        return points
    }
}
