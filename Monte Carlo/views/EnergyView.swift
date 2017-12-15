//
//  EnergyView.swift
//  Monte Carlo
//
//  Created by apple on 14.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import AppKit

class EnergyView: NSView {
    
    var mesh: Mesh? {
        didSet {
            self.energyCanvas.mesh = self.mesh
        }
    }
    
    func updateUI() {
        self.energyCanvas.updateUI()
    }
    
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var energyCanvas: EnergyCanvas!
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.initViews()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.initViews()
    }
    
    private func initViews() {
        Bundle.main.loadNibNamed(NSNib.Name("EnergyView"), owner: self, topLevelObjects: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.width, .height]
    }
}
