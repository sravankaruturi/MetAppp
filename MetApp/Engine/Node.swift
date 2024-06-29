//
//  Node.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Node {
    
    var position: SIMD3<Float> = SIMD3<Float>(0, 0, 0)
    var rotation: SIMD3<Float> = SIMD3<Float>(0, 0, 0)
    var scale: SIMD3<Float> = SIMD3<Float>(1, 1, 1)
    
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(position)
        modelMatrix.rotate(rotation)
        modelMatrix.scale(scale)
        return modelMatrix
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder ) {
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
        
    }
    
}
