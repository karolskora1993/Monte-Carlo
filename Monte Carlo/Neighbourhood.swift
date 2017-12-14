//
//  NeighbourhoodFinder.swift
//  Monte Carlo
//
//  Created by apple on 06.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

protocol Neighbourhood {
    func generateNeighbourhood(forMCPoints points: [[MCPoint]], i:Int, j:Int) -> [[MCPoint]]
}
