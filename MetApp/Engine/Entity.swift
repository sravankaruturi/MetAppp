//
//  Entity.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Entity {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer?
    
    init() {
        createVertices()
    }
    
    func createBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: Vertex.size() * vertices.count, options: [])
    }
    
    func draw(re: MTLRenderCommandEncoder) {
        guard let vertexBuffer = vertexBuffer else {
            print("Vertex buffer not initialized")
            return
        }
        
        re.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
        re.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        re.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
    
    func createVertices() {
        vertices = [
            Vertex(position: [0, 1, 0], color: [1, 0, 0, 1]),
            Vertex(position: [-1, -1, 0], color: [0, 1, 0, 1]),
            Vertex(position: [1, -1, 0], color: [0, 0, 1, 1])
        ]
    }
}
