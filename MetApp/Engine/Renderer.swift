//
//  Renderer.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit
import SwiftUI

class Renderer: NSObject {
    
    var scene: Entity
    
    override init() {
        self.scene = Player()
        
        super.init()
    }
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
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
