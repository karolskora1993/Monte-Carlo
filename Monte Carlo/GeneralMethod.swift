//
//  GeneralMethod.swift
//  Monte Carlo
//
//  Created by apple on 03.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

protocol GeneralMethod {
    func nextStep(withMCPoints points: [[MCPoint]]) -> [[MCPoint]]
}

extension GeneralMethod {
    
    func getNeighbourhood(forMCPoints points: [[MCPoint]], i:Int, j:Int) -> [[MCPoint]] {
        var temp = [[MCPoint]]()
        let point = MCPoint()
        let size = (height: points.count, width:points[0].count)
        for _ in 0..<3 {
            temp.append([point, point, point])
        }
        
        if i == 0 && j == 0 {
            for k in 0..<2 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else if i == 0 && j != 0 && j != size.height - 1 {
            for k in 0..<2 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else if i == 0 && j == size.height - 1 {
            for k in 0..<2 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
            
        else if  i == size.width - 1 && j == 0 {
            for k in -1..<1 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else if  i == size.width - 1 && j != 0 && j != size.height - 1 {
            for k in -1..<1 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else if i != 0 && j == size.height - 1 && i != size.width - 1 {
            for k in -1..<2 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else if i == size.width - 1 && j == size.height - 1 {
            for k in -1..<1 {
                for l in -1..<1 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
            
        else if i != 0 && j == 0 && i != size.width - 1 {
            for k in -1..<2 {
                for l in 0..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        else {
            for k in -1..<2 {
                for l in -1..<2 {
                    temp[k + 1][l + 1] = points[i + k][j + l]
                }
            }
        }
        return temp
    }
}
