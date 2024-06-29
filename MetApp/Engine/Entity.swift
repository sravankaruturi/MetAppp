//
//  Entity.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Entity : Node {
    
    var mesh: Mesh!
    var meshType: MeshTypes
    
    init(meshType: MeshTypes) {
        self.meshType = meshType
    }
    
    func createBuffers(device: MTLDevice) {
        mesh = MeshLibrary.getMesh(.Rectangle_Custom)
        mesh.createBuffers(device: device)
    }

}

extension Entity : Renderable {
    
    func doRender(_ renderCommandEncoder: any MTLRenderCommandEncoder) {
        guard let vertexBuffer = mesh.vertexBuffer else {
            print("Vertex buffer not initialized")
            return
        }
        
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
    
}
