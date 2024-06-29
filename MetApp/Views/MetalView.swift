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
        
        mtkView.clearColor = MTLClearColor(red: 0, green: 1, blue: 0, alpha: 0)
        
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        
        return mtkView
    }
    
    
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
        
    }
    
    
    class Coordinator : NSObject, MTKViewDelegate {
        
        var parent: MetalView
        var metalCommandQueue: MTLCommandQueue!
        
        var vertices: [Vertex]!
        
        var vertexBuffer: MTLBuffer!
        
        var renderPipelineState: MTLRenderPipelineState!
        
        init(_ parent: MetalView) {
            
            self.parent = parent
            super.init()
            
        }
        
        func setup() {
            
            self.metalCommandQueue = Engine.Device.makeCommandQueue()!
            
            createVertices()
            createRenderPipeLineState()
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
        
        func createRenderPipeLineState(){
            
            let library = Engine.Device.makeDefaultLibrary()
            
            let vertexFunction = library?.makeFunction(name: "vertex_shader")
            let fragmentFunction = library?.makeFunction(name: "fragment_shader")
            
            let vertexDescriptor = MTLVertexDescriptor()
            
            // Position
            vertexDescriptor.attributes[0].format = .float3
            vertexDescriptor.attributes[0].bufferIndex = 0
            vertexDescriptor.attributes[0].offset = 0
            
            // Color
            vertexDescriptor.attributes[1].format = .float4
            vertexDescriptor.attributes[1].bufferIndex = 0
            vertexDescriptor.attributes[1].offset = SIMD3<Float>.size()
            
            vertexDescriptor.layouts[0].stride = Vertex.stride()
            
            
            let rpd = MTLRenderPipelineDescriptor()
            rpd.colorAttachments[0].pixelFormat = .bgra8Unorm
            rpd.vertexFunction = vertexFunction
            rpd.fragmentFunction = fragmentFunction
            rpd.vertexDescriptor = vertexDescriptor
            
            do {
                renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: rpd)
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
