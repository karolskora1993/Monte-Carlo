//
//  Mesh.swift
//  Monte Carlo
//
//  Created by apple on 21.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class Mesh {
    
    var points = [[MCPoint]]()
    var size:(height: Int, width: Int)
    var started = false
    var nextID = 1
    var chosenPoints = [[Bool]]()
    var maxID = 20
    
    init(withSize size: (height: Int, width: Int)) {
        self.size = size
        self.initPoints()
        self.initChosenPoints()
    }
    
    func isCompleted() -> Bool {
        for row in self.points {
            for el in row {
                if el.id == 0 {
                    return false
                }
            }
        }
        if self.started {
            self.started = false
        }
        return true
    }
    
    private func initPoints() {
        for i in 0..<self.size.height {
            var row = [MCPoint]()
            for j in 0..<self.size.width {
                row.append(MCPoint(id: 0, phase: 0, x: i, y: j))
            }
            self.points.append(row)
        }
    }
    
    func fillRandomly(withMaxID maxID:Int) {
        self.maxID = maxID
        for i in 0..<self.size.height {
            for j in 0..<self.size.width {
                let randomID = Int(arc4random_uniform(UInt32(maxID))) + 1
                self.points[i][j].id = randomID
            }
        }
    }
    
    func changeStarted() {
        self.started = !self.started
    }
    
    func generateRandom(grainsCount: Int) {
        for _ in 0..<grainsCount {
            var x = Int(arc4random_uniform(UInt32(self.size.height)))
            var y = Int(arc4random_uniform(UInt32(self.size.width)))
            while self.points[x][y].id != 0 {
                x = Int(arc4random_uniform(UInt32(self.size.height)))
                y = Int(arc4random_uniform(UInt32(self.size.width)))
            }
            self.points[x][y].id = self.nextID
            self.nextID += 1
        }
    }
    
    private func clearPoints() {
        self.points = [[MCPoint]]()
        self.chosenPoints = [[Bool]]()
    }
    
    private func initChosenPoints() {
        for _ in 0..<self.size.height {
            var row = [Bool]()
            for _ in 0..<self.size.width {
                row.append(false)
            }
            self.chosenPoints.append(row)
        }
    }
    
    private func clearChosenPoints() {
        for i in 0..<self.size.height {
            for j in 0..<self.size.width {
                self.chosenPoints[i][j] = false
            }
        }
    }
    
    private func checkForNotDrownElements() -> Bool {
        for row in self.chosenPoints {
            for element in row {
                if !element {
                    return true
                }
            }
        }
        return false
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
    
    func nextCA() {
        var nextStep = NSArray(array: self.points, copyItems: true)
        for i in 0..<self.size.height {
            for j in 0..<self.size.width {
                if self.points[i][j].id == 0 {
                    let neighbours = self.getNeighbourhood(i: i, j: j)
                    
                }
            }
        }
    }
    
    func next() {
        self.clearChosenPoints()
        while self.checkForNotDrownElements() {
            var x = Int(arc4random_uniform(UInt32(self.size.height)))
            var y = Int(arc4random_uniform(UInt32(self.size.width)))
            while self.chosenPoints[x][y] {
                x = Int(arc4random_uniform(UInt32(self.size.height)))
                y = Int(arc4random_uniform(UInt32(self.size.width)))
            }
            let chosenID = self.points[x][y].id
            let neighbours = self.getNeighbourhood(i: x, j: y)
            let newID = self.drawNewID(forNeighbours: neighbours)
            if self.calculateEnergy(forChosenID: newID, neighbourhood: neighbours) <= self.calculateEnergy(forChosenID: chosenID, neighbourhood: neighbours) {
                self.points[x][y].id = newID
            }
            self.chosenPoints[x][y] = true
        }
    }
    
    private func getNeighbourhood(i:Int, j:Int) -> [[MCPoint]] {
        var temp = [[MCPoint]]()
        let point = MCPoint(id: 0, phase: 0, x: 0, y: 0)
        for _ in 0..<3 {
            temp.append([point, point, point])
        }
        
        if i == 0 && j == 0 {
            for k in 0..<2 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else if i == 0 && j != 0 && j != self.size.height - 1 {
            for k in 0..<2 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else if i == 0 && j == self.size.height - 1 {
            for k in 0..<2 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        
        else if  i == self.size.width - 1 && j == 0 {
            for k in -1..<1 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else if  i == self.size.width - 1 && j != 0 && j != self.size.height - 1 {
            for k in -1..<1 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else if i != 0 && j == self.size.height - 1 && i != self.size.width - 1 {
            for k in -1..<2 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else if i == self.size.width - 1 && j == self.size.height - 1 {
            for k in -1..<1 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        
        else if i != 0 && j == 0 && i != self.size.width - 1 {
            for k in -1..<2 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        else {
            for k in -1..<2 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = self.points[i + k][j + l]
                }
            }
        }
        return temp
    }
}
