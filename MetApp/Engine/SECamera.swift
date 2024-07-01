//
//  Camera.swift
//  MetApp
//
//  Created by Sravan Karuturi on 7/1/24.
//

import simd

enum SECameraTypes {
    
    case Debug
    
}

protocol SECamera {
    
    var cameraType: SECameraTypes { get }
    var position: SIMD3<Float> { get set }
    var projectionMatrix: matrix_float4x4 { get }
    func update(deltaTime: Float)
    
}

extension SECamera {
    
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        viewMatrix.translate(-position)
        
        return viewMatrix
    }
    
}
