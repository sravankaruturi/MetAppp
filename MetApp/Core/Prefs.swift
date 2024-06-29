//
//  Prefs.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

public enum ClearColors {
    
    static let black = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let white = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let gray = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let red = MTLClearColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let green = MTLClearColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    static let blue = MTLClearColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    
}

class Prefs {
    
    public static var ClearColor: MTLClearColor = ClearColors.green
    public static var MainPixelFormat: MTLPixelFormat = .bgra8Unorm
    
}
