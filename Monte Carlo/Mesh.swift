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
    
    init(withSize size: (height: Int, width: Int), maxID: Int) {
        self.size = size
        self.initPoints(maxID: maxID)
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
    
    private func initPoints(maxID:Int) {
        for i in 0..<self.size.height {
            var row = [MCPoint]()
            for j in 0..<self.size.width {
                let randomID = Int(arc4random_uniform(UInt32(maxID)))
                row.append(MCPoint(id: randomID, phase: 0, x: i, y: j))
            }
            points.append(row)
        }
    }
    
    func next() {
        //TODO: next func implementation
    }
    
    private func getNeighboorhood(i:Int, j:Int) -> [[MCPoint]] {
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
