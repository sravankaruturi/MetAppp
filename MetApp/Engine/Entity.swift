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
    
    private var material: Material = Material()
    
    var modelConstants: ModelConstants = ModelConstants()
    
    init(meshType: MeshTypes) {
        self.meshType = meshType
        mesh = MeshLibrary.getMesh(meshType)
        mesh.createBuffers(device: Engine.Device)
    }
    
    override func update(deltaTime: Float){
        
        updateModelConstants()
        
    }
    
    private func updateModelConstants() {
        
        modelConstants.modelMatrix = self.modelMatrix
        
    }

}

extension Entity : Renderable {
    
    func doRender(_ renderCommandEncoder: any MTLRenderCommandEncoder) {
        guard let vertexBuffer = mesh.vertexBuffer else {
            print("Vertex buffer not initialized")
            return
        }
        
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.getRenderPipelineState(.Basic))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.DepthStencilState(.Less))
        
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(), index: 2)
        
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride(), index: 1)
        
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
    
}

// Material Properties

extension Entity {
    
    public func setColor(_ color: SIMD4<Float>) {
        self.material.color = color
        self.material.useMatrialColor = true
    }
    
}
