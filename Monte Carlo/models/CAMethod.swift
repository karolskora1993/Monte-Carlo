//
//  CAMethod.swift
//  Monte Carlo
//
//  Created by apple on 03.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class CAMethod: GeneralMethod {
    func nextStep(withMCPoints points: [[MCPoint]], andNeighbourhood neighbourhood: Neighbourhood) -> [[MCPoint]] {
        let size = (height: points.count, width: points[0].count)
        var nextStep = points
        for i in 0..<size.height {
            for j in 0..<size.width {
                if points[i][j].id == 0  && points[i][j].selected == false {
                    let neighbours = neighbourhood.generateNeighbourhood(forMCPoints: points, i: i, j: j)
                    var ids = [Int:Int]()
                    for row in neighbours {
                        for el in row {
                            if el.id != 0 && el.selected == false {
                                if let count = ids[el.id] {
                                    ids[el.id] = count + 1
                                }else {
                                    ids[el.id] = 1
                                }
                            }
                        }
                    }
                    if !ids.isEmpty {
                        let maxElement = ids.max{ a, b in a.value < b.value}
                        if let maxID = maxElement?.0 {
                            nextStep[i][j].id = maxID
                        }
                    }
                }
            }
        }
        return nextStep
    }
}
