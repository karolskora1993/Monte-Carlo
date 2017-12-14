//
//  GeneralMethod.swift
//  Monte Carlo
//
//  Created by apple on 03.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

protocol GeneralMethod {
    func nextStep(withMCPoints points: [[MCPoint]], andNeighbourhood neighbourhood: Neighbourhood) -> [[MCPoint]]
}
