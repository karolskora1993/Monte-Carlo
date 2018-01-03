//
//  NucleationType.swift
//  Monte Carlo
//
//  Created by apple on 03.01.2018.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation


protocol Nucleationtype {
    var nucleonsCount: Int {get set}
    var onEdges: Bool {get set}
    func addNucleons(forPoints points: [[MCPoint]]) -> [[MCPoint]]
}

class ConstantNucleation: Nucleationtype {
    var nucleonsCount: Int = 0
    var onEdges: Bool = false
    
    
    func addNucleons(forPoints points: [[MCPoint]]) -> [[MCPoint]] {
        var points = points
        let size = (height: points.count, width: points[0].count)
        for _ in 0..<nucleonsCount {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].recrystalized || (onEdges && points[x][y].boundaryPoint) {
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
    var nucleonsCount: Int = 0
    var onEdges: Bool = false
    
    func addNucleons(forPoints points: [[MCPoint]]) -> [[MCPoint]] {
        self.nucleonsCount *= 2
        var points = points
        let size = (height: points.count, width: points[0].count)
        for _ in 0..<self.nucleonsCount {
            var x = Int(arc4random_uniform(UInt32(size.height)))
            var y = Int(arc4random_uniform(UInt32(size.width)))
            while points[x][y].recrystalized || (onEdges && points[x][y].boundaryPoint) {
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
    var nucleonsCount: Int = 0
    var onEdges: Bool = false
    
    func addNucleons(forPoints points: [[MCPoint]]) -> [[MCPoint]] {
        var points = points
        if self.checkForFirstNucleation(forPoints: points) {
            let size = (height: points.count, width: points[0].count)
            for _ in 0..<nucleonsCount {
                var x = Int(arc4random_uniform(UInt32(size.height)))
                var y = Int(arc4random_uniform(UInt32(size.width)))
                while points[x][y].recrystalized  || (onEdges && points[x][y].boundaryPoint) {
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
