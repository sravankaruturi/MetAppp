//
//  MetalView.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

import MetalKit
import SwiftUI


struct MetalView: NSViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
        
        let mtkView = MTKView()
        
        mtkView.delegate = context.coordinator
        
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true // Maybe not what we want
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            print(metalDevice)
            mtkView.device = metalDevice
            Engine.Setup(device: metalDevice)
        }
        
        context.coordinator.setup()
        
        mtkView.framebufferOnly = false
        
        mtkView.clearColor = Prefs.ClearColor
        
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        
        return mtkView
    }
    
    
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
        
    }
    
    
    class Coordinator : NSObject, MTKViewDelegate {
        
        var parent: MetalView
        
        var vertices: [Vertex]!
        
        var vertexBuffer: MTLBuffer!
        
        init(_ parent: MetalView) {
            
            self.parent = parent
            super.init()
            
        }
        
        func setup() {
            
            createVertices()
            createBuffers()
            
        }
        
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func createBuffers(){
            vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.size() * vertices.count, options: [])
        }
        
        func createVertices() {
            
            vertices = [
                
                Vertex(position: [0, 1, 0], color: [1, 0, 0, 1]),
                Vertex(position: [-1, -1, 0], color: [0, 1, 0, 1]),
                Vertex(position: [1, -1, 0], color: [0, 0, 1, 1])
                
                ]
            
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
            re?.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
            
            // Send Info to render command encoder.
            re?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            re?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
            
            re?.endEncoding()
            
            commandBuffer?.present(drawable)
            
            commandBuffer?.commit()
        }
        
    }
}
