//
//  Renderer.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit
import SwiftUI

class Renderer: NSObject {
    
    var entity: Entity
    
    override init() {
        self.entity = Player()
        super.init()
    }
    
    func setupBuffers() {
        entity.createBuffers(device: Engine.Device)
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
        
        entity.render(renderCommandEncoder: re!)
        
        re?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
}
