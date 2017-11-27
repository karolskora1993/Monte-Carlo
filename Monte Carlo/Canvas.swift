//
//  Canvas.swift
//  Monte Carlo
//
//  Created by apple on 21.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import AppKit

class Canvas: NSView, UIUpdateDelegate {
    
    var mesh: Mesh?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.initView()
    }
    
    func updateUI() {
        self.draw(self.frame)
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
        super.draw(dirtyRect)
        if let mesh = self.mesh, mesh.points.count > 0 {
            let context = NSGraphicsContext.current?.cgContext
            let rectSize = self.frame.size.height / CGFloat(mesh.size.height)
            for i in 0..<mesh.size.height {
                for j in 0..<mesh.size.width {
                    let id = mesh.points[i][j].id
                    let color = ColorPicker.getColor(withID: id)
                    let rect = NSRect(x: CGFloat(j) * rectSize , y: CGFloat(i) * rectSize, width: rectSize, height: rectSize)
                    color.set()
                    context?.fill(rect)
                }
            }
            context?.restoreGState()
        }
    }
}
