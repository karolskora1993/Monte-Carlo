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
    static var nextID = 1
    var maxID = 20
    var method: GeneralMethod
    var neighbourhood: Neighbourhood = MooreNeighbourhood()
    
    init(withSize size: (height: Int, width: Int), nextStepMethod: GeneralMethod = MCMethod()) {
        self.size = size
        self.method = nextStepMethod
        self.initPoints()
    }
    
    func setCAMethod() {
        self.method = CAMethod()
    }
    
    func setMCMethod() {
        self.method = MCMethod()
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
    
    func isRecrystalized() -> Bool {
        for row in self.points {
            for el in row {
                if !el.recrystalized {
                    return false
                }
            }
        }
        return true
    }
    
    func select(numberOfGrains:Int) {
        let max = self.nextID == 1 ? self.maxID : self.nextID
        var selectedIds = [Int]()
        for _ in 0..<numberOfGrains {
            var id = Int(arc4random_uniform(UInt32(max)))
            while selectedIds.contains(id) {
                id = Int(arc4random_uniform(UInt32(max)))
            }
            selectedIds.append(id)
        }
        self.selectPoints(withIDs: selectedIds)
    }
    
    private func selectPoints(withIDs ids:[Int]) {
        for i in 0..<self.size.height {
            for j  in 0..<self.size.width {
                if ids.contains(self.points[i][j].id) {
                    self.points[i][j].selected = true
                    self.points[i][j].id = -1
                }else {
                    self.points[i][j].selected = false
                    self.points[i][j].id = 0
                }
            }
        }
        self.nextID = 1
    }
    
    func clearPoints() {
        self.points = MCPoint.clearPoints(forMCPoints: self.points)
    }
    
    private func initPoints() {
        for i in 0..<self.size.height {
            var row = [MCPoint]()
            for j in 0..<self.size.width {
                row.append(MCPoint(withID: 0, x: i, y: j))
            }
            self.points.append(row)
        }
    }
    
    func fillRandomly(withMaxID maxID:Int) {
        self.maxID = maxID
        for i in 0..<self.size.height {
            for j in 0..<self.size.width {
                if !self.points[i][j].selected {
                    let randomID = Int(arc4random_uniform(UInt32(maxID))) + 1
                    self.points[i][j].id = randomID
                }
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
    
    func next() {
        self.points = self.method.nextStep(withMCPoints: self.points, andNeighbourhood: self.neighbourhood)
    }
    
    func nextRectrystalizationStep() {
        self.points = self.method.nextStep(withMCPoints: self.points, andNeighbourhood: self.neighbourhood)
    }
    func distribureEnergy(energyInside:Int, energyOnBounds: Int) {
        self.points = Recrystallization.distribute(forPoints: self.points, neighbourhood: self.neighbourhood, internalEnergy: energyInside, andBoundaryEnergy: energyOnBounds)
    }
    
}
