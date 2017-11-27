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

class MyThread: Thread {
    
    weak var delegate: UIUpdateDelegate?
    var mesh: Mesh?
    
    func main() {
        if let mesh = self.mesh, mesh.points.count >0 {
            while mesh.isRunning() && !mesh.isCompleted() {
                mesh.next()
                if let delegate = self.delegate {
                    delegate.updateUI()
                }
            }
        }
    }
}
