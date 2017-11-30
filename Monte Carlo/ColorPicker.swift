//
//  ColorPicker.swift
//  Monte Carlo
//
//  Created by apple on 26.11.2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import AppKit

class ColorPicker {
    
    static func getColor(withID id:Int, alpha:CGFloat = 1) ->NSColor {
        var r, g, b: Int
        
        if id == 0 {
            return NSColor(red: 0, green: 0, blue: 0, alpha: alpha)
        }
        if id == -1 {
            return NSColor(red: 255, green: 255, blue: 255, alpha: alpha)
        }
        if id == -2 {
            return NSColor(red: 255, green: 0, blue: 0, alpha: alpha)
        }
        if id % 2 == 0 {
            r = (255 - 15 * id) % 255
            g = (20 + 22 * id) % 255
            b = (100 - 17 * id) % 255
        }
        else if id % 3 == 0 {
            r = (100 + 15 * id) % 255
            g = (255 - 22 * id) % 255
            b = (20 + 17 * id) % 255
        }
        else if id % 5 == 0 {
            r = (200 - 5 * id) % 255
            g = (40 - 18 * id) % 255
            b = (120 + 17 * id) % 255
        }
        else {
            r = (100 - 15 * id) % 255
            g = (255 - 5 * id) % 255
            b = (20 + 14 * id) % 255
        }
        
        r = r < 0 ? 0 : r
        g = g < 0 ? 0 : g
        b = b < 0 ? 0 : b
        
        let float_r = CGFloat(r) / 255
        let float_g = CGFloat(g) / 255
        let float_b = CGFloat(b) / 255


        return NSColor(red: float_r, green: float_g, blue: float_b, alpha: alpha)
    }
}
