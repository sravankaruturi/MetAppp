//
//  Engine.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Engine {
    
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Setup(device: MTLDevice) {
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        
        ShaderLibrary.setup()
        VertexDescriptorLibrary.setup()
        RenderPipeLineDescriptorLibrary.setup()
        RenderPipelineStateLibrary.setup()
        MeshLibrary.setup()
        
    }
    
}
