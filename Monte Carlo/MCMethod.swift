//
//  MCMethod.swift
//  Monte Carlo
//
//  Created by apple on 03.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class MCMethod: GeneralMethod {
    
    func nextStep(withMCPoints points: [[MCPoint]]) -> [[MCPoint]] {
        let size = (height: points.count, width: points[0].count)
        var points = MCPoint.clearChosen(forMCPoints: points)
        while MCPoint.chechForNotDrawnElements(forPoints: points) {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].chosen || points[x][y].selected {
                x = Int(arc4random_uniform(UInt32(size.height)))
                y = Int(arc4random_uniform(UInt32(size.width)))
            }
            let chosenID = points[x][y].id
            let neighbours = self.getNeighbourhood(forMCPoints: points, i: x, j: y)
            let newID = self.drawNewID(forNeighbours: neighbours)
            if self.calculateEnergy(forChosenID: newID, neighbourhood: neighbours) <= self.calculateEnergy(forChosenID: chosenID, neighbourhood: neighbours) {
                points[x][y].id = newID
            }
            points[x][y].chosen = true
        }
        return points
    }
    
    private func drawNewID(forNeighbours ids:[[MCPoint]]) ->Int {
        var x = Int(arc4random_uniform(UInt32(ids.count)))
        var y = Int(arc4random_uniform(UInt32(ids[0].count)))
        while x == y || ids[x][y].id == 0 {
            x = Int(arc4random_uniform(UInt32(ids.count)))
            y = Int(arc4random_uniform(UInt32(ids[0].count)))
        }
        return ids[x][y].id
    }
    
    private func calculateEnergy(forChosenID chosenID:Int, neighbourhood:[[MCPoint]]) -> Int {
        var energy = 0
        for row in neighbourhood {
            for element in row {
                if element.id != chosenID && element.id != 0 {
                    energy += 1
                }
            }
        }
        return energy
    }
    
    
}
