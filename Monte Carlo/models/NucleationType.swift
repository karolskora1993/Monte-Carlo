//
//  NucleationType.swift
//  Monte Carlo
//
//  Created by apple on 03.01.2018.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation


protocol Nucleationtype {
    func addNucleons(forPoints points: [[MCPoint]], nucleonsCount: Int, onEdges:Bool) -> [[MCPoint]]
}

class ConstantNucleation: Nucleationtype {
    
    func addNucleons(forPoints points: [[MCPoint]], nucleonsCount: Int, onEdges:Bool = false) -> [[MCPoint]] {
        var points = points
        let size = (height: points.count, width: points[0].count)
        for _ in 0..<nucleonsCount {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].recrystalized {
                x = Int(arc4random_uniform(UInt32(size.height)))
                y = Int(arc4random_uniform(UInt32(size.width)))
            }
            points[x][y].id = Mesh.nextID
            points[x][y].recrystalized = true
            Mesh.nextID += 1
        }
        return points
    }
}

class IncreasingNucleation: Nucleationtype {
    
    var lastCount = 0
    func addNucleons(forPoints points: [[MCPoint]], nucleonsCount: Int, onEdges:Bool = false) -> [[MCPoint]] {
        self.lastCount += nucleonsCount
        var points = points
        let size = (height: points.count, width: points[0].count)
        for _ in 0..<self.lastCount {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].recrystalized {
                x = Int(arc4random_uniform(UInt32(size.height)))
                y = Int(arc4random_uniform(UInt32(size.width)))
            }
            points[x][y].id = Mesh.nextID
            points[x][y].recrystalized = true
            Mesh.nextID += 1
        }
        return points
    }
}

class AtBeginNucleation: Nucleationtype {
    func addNucleons(forPoints points: [[MCPoint]], nucleonsCount: Int, onEdges:Bool = false) -> [[MCPoint]] {
        var points = points
        if self.checkForFirstNucleation(forPoints: points) {
            let size = (height: points.count, width: points[0].count)
            for _ in 0..<nucleonsCount {
                var x = Int(arc4random_uniform(UInt32(size.height)))
                var y = Int(arc4random_uniform(UInt32(size.width)))
                while points[x][y].recrystalized {
                    x = Int(arc4random_uniform(UInt32(size.height)))
                    y = Int(arc4random_uniform(UInt32(size.width)))
                }
                points[x][y].id = Mesh.nextID
                points[x][y].recrystalized = true
                Mesh.nextID += 1
            }
        }
        return points
    }
    
    func checkForFirstNucleation(forPoints points: [[MCPoint]]) -> Bool {
        for row in points {
            for el in row {
                if el.recrystalized {
                    return false
                }
            }
        }
        return true
    }
}
