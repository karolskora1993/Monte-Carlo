//
//  Thread.swift
//  Monte Carlo
//
//  Created by apple on 27.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation


protocol UIUpdateDelegate: class {
    func updateUI()
}

class MCThread: Thread {
    
    weak var delegate: UIUpdateDelegate?
    var mesh: Mesh?
    var numberOfSteps = 100
    
    override func main() {
        if let mesh = self.mesh, mesh.points.count > 0 {
            for _ in 0..<numberOfSteps {
                mesh.next()
                if let delegate = self.delegate {
                DispatchQueue.main.async {
                        delegate.updateUI()
                    }
                }
            }
        }
    }
}
