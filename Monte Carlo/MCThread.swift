//
//  Thread.swift
//  Monte Carlo
//
//  Created by apple on 27.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation


protocol UIUpdateDelegate: class {
    func updateCanvas()
    func updateStarted()
}

class MCThread: Thread {
    
    weak var delegate: UIUpdateDelegate?
    var mesh: Mesh?
    var numberOfSteps = 100
    
    override func main() {
        if let mesh = self.mesh, mesh.points.count > 0 {
            for i in 0..<numberOfSteps {
                if !mesh.started {
                    break
                }
                mesh.next()
                if let delegate = self.delegate {
                DispatchQueue.main.async {
                        delegate.updateCanvas()
                    }
                }
                print("next: \(i)")
                Thread.sleep(forTimeInterval: 0.1)
            }
        }
        DispatchQueue.main.async {
            self.delegate?.updateStarted()
        }
    }
}
