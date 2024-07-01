//
//  Renderer.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit
import SwiftUI

class Renderer: NSObject {
    
    public static var ScreenSize = SIMD2<Float>(x: 0, y: 0)
    public static var AspectRatio: Float {
        return ScreenSize.x / ScreenSize.y
    }
    
    var scene: EScene
    
    override init() {
        self.scene = SandboxScene()
        super.init()
        // TODO: Does this work fine without the calling updateScreenSize here?
        
    }
    
}

extension Renderer: MTKViewDelegate {
    
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = SIMD2<Float>(x: Float(view.bounds.size.width), y: Float(view.bounds.size.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func draw(in view: MTKView) {
        
        guard let drawable = view.currentDrawable else {
            return
        }
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        
        let rpd = view.currentRenderPassDescriptor
        rpd?.colorAttachments[0].clearColor = Prefs.ClearColor
        rpd?.colorAttachments[0].loadAction = .clear
        rpd?.colorAttachments[0].storeAction = .store
        
        let re = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd!)
        
        scene.update(deltaTime: 1.0/60)
        
        scene.render(renderCommandEncoder: re!)
        
        re?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
    
}
