//
//  ColorGradientView.swift
//  Monte Carlo
//
//  Created by apple on 14.12.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Cocoa

class ColorGradientView: NSView {
    
    let startColor = NSColor(red: 0, green: 0, blue: 1, alpha: 1)
    let endColor = NSColor(red: 1, green: 0, blue: 0, alpha: 1)

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let gradient = NSGradient(starting: self.startColor, ending: self.endColor)
        gradient?.draw(in: dirtyRect, angle: 90)
    }
}
