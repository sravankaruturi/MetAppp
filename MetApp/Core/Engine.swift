//
//  Engine.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Engine {
    
    public static var Device: MTLDevice!
    
    public static func Setup(device: MTLDevice) {
        self.Device = device
    }
    
}
