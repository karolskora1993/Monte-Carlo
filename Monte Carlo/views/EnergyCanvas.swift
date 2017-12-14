//
//  Canvas.swift
//  Monte Carlo
//
//  Created by apple on 21.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import AppKit

class EnergyCanvas: NSView {
    
    var mesh: Mesh? {
        didSet{
            self.updateUI()
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.initView()
    }
    
    func updateUI() {
        self.setNeedsDisplay(self.bounds)
    }
    
    func initView() {
        self.mesh = nil
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.initView()
    }
    
    func setMesh(mesh: Mesh) {
        self.mesh = mesh
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if let mesh = self.mesh, mesh.points.count > 0 {
            let context = NSGraphicsContext.current?.cgContext
            let rectSize = self.frame.size.height / CGFloat(mesh.size.height)
            for i in 0..<mesh.size.height {
                for j in 0..<mesh.size.width {
                    let energy = mesh.points[i][j].energy
                    let color = ColorPicker.getEnergyColor(withEnergy: energy)
                    let rect = NSRect(x: CGFloat(j) * rectSize , y: CGFloat(i) * rectSize, width: rectSize, height: rectSize)
                    color.setFill()
                    context?.fill(rect)
                }
            }
        }
        super.draw(dirtyRect)
    }
}
