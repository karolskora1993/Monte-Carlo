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
    
    static func nextStep(forPoints points: [[MCPoint]], andNucleationType nucleationType: Nucleationtype, neighbourhood: Neighbourhood) -> [[MCPoint]] {
        var points = nucleationType.addNucleons(forPoints: points)
        let size = (height: points.count, width: points[0].count)
        points = MCPoint.clearChosen(forMCPoints: points)
        while MCPoint.chechForNotDrawnElements(forPoints: points) {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].chosen || points[x][y].selected || points[x][y].recrystalized {
                x = Int(arc4random_uniform(UInt32(size.height)))
                y = Int(arc4random_uniform(UInt32(size.width)))
            }
            var chosenPoint = points[x][y]
            let neighbours = neighbourhood.generateNeighbourhood(forMCPoints: points, i: x, j: y)
            if let newID = self.checkForRecrystalizedNeighbours(forNeighbourhood: neighbours) {
                let oldEnergy = self.calculateEnergy(OfElement: chosenPoint, withNeighbourhood: neighbours, recrystalized: false)
                chosenPoint.id = newID
                chosenPoint.energy = 0
                let newEnergy = self.calculateEnergy(OfElement: points[x][y], withNeighbourhood: neighbours, recrystalized: false)
                if newEnergy <= oldEnergy {
                    points[x][y] = chosenPoint
                }
            }
        }
        return points
    }
    
    private static func checkForRecrystalizedNeighbours(forNeighbourhood neighbours: [[MCPoint]]) -> Int? {
        var recrID: Int?
        for row in neighbours {
            for el in row {
                if el.recrystalized {
                    recrID = el.id
                    return recrID
                }
            }
        }
        return recrID
    }
    
    private static func calculateEnergy(OfElement element:MCPoint, withNeighbourhood neighbourhood:[[MCPoint]], recrystalized: Bool) -> Int {
        var energy = 0
        let chosenID = element.id
        for row in neighbourhood {
            for el in row {
                if el.id != chosenID && el.id != 0 && !el.selected {
                    energy += 1
                }
            }
        }
        return (recrystalized ? energy : energy + element.energy)
    }
}
