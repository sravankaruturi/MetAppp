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
        
        var renderPipelineState: MTLRenderPipelineState!
        
        init(_ parent: MetalView) {
            
            self.parent = parent
            super.init()
            
        }
        
        func setup() {
            
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
            rpd.colorAttachments[0].pixelFormat = Prefs.MainPixelFormat
            rpd.vertexFunction = ShaderLibrary.getVertexShaderFunction(.Basic)
            rpd.fragmentFunction = ShaderLibrary.getFragmentShaderFunction(.Basic)
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
            
            let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
            
            let rpd = view.currentRenderPassDescriptor
            rpd?.colorAttachments[0].clearColor = Prefs.ClearColor
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
