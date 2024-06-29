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
        }
        
        mtkView.framebufferOnly = false
        
        mtkView.clearColor = MTLClearColor(red: 0, green: 1, blue: 0, alpha: 0)
        
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        
        return mtkView
    }
    
    
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
        
    }
    
    
    class Coordinator : NSObject, MTKViewDelegate {
        
        struct Vertex {
            var position: SIMD3<Float>
            var color: SIMD4<Float>
        }
        
        var parent: MetalView
        var metalDevice: MTLDevice!
        var metalCommandQueue: MTLCommandQueue!
        
        var vertices: [Vertex]!
        
        var vertexBuffer: MTLBuffer!
        
        var renderPipelineState: MTLRenderPipelineState!
        
        init(_ parent: MetalView) {
            
            self.parent = parent
            if let metalDevice = MTLCreateSystemDefaultDevice() {
                self.metalDevice = metalDevice
            }
            
            self.metalCommandQueue = metalDevice.makeCommandQueue()!
            super.init()
            
            createVertices()
            
            createRenderPipeLineState()
            createBuffers()
            
        }
        
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func createBuffers(){
            vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.size * vertices.count, options: [])
        }
        
        func createVertices() {
            
            vertices = [
                
                Vertex(position: [0, 1, 0], color: [1, 0, 0, 1]),
                Vertex(position: [-1, -1, 0], color: [0, 1, 0, 1]),
                Vertex(position: [1, -1, 0], color: [0, 0, 1, 1])
                
                ]
            
        }
        
        func createRenderPipeLineState(){
            
            let library = metalDevice.makeDefaultLibrary()
            
            let vertexFunction = library?.makeFunction(name: "vertex_shader")
            let fragmentFunction = library?.makeFunction(name: "fragment_shader")
            
            let rpd = MTLRenderPipelineDescriptor()
            rpd.colorAttachments[0].pixelFormat = .bgra8Unorm
            rpd.vertexFunction = vertexFunction
            rpd.fragmentFunction = fragmentFunction
            
            do {
                renderPipelineState = try metalDevice.makeRenderPipelineState(descriptor: rpd)
                print("Render Pipeline State Set")
            }catch{
                print(error)
            }
            
        }
        
        
        func draw(in view: MTKView) {
            
            guard let drawable = view.currentDrawable else {
                return
            }
            
            let commandBuffer = metalCommandQueue.makeCommandBuffer()
            
            let rpd = view.currentRenderPassDescriptor
            rpd?.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 0.5, 1)
            rpd?.colorAttachments[0].loadAction = .clear
            rpd?.colorAttachments[0].storeAction = .store
            
            
            let re = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd!)
            re?.setRenderPipelineState(renderPipelineState)
            
            // Send Info to render command encoder.
            re?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            re?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
            
            re?.endEncoding()
            
            commandBuffer?.present(drawable)
            
            commandBuffer?.commit()
        }
        
    }
}
