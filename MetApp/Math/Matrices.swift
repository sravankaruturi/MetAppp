//
//  Matrices.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

extension matrix_float4x4 {
    
    mutating func translate(_ translation: vector_float3) {
        
        var result = matrix_identity_float4x4
        result[3] = vector4(translation, 1)
        
        self = matrix_multiply(self, result)
        
    }
    
    mutating func scale( _ scale: vector_float3 ) {
        
        var result = matrix_identity_float4x4
        
        result[0][0] = scale.x
        result[1][1] = scale.y
        result[2][2] = scale.z
        
        self = matrix_multiply(self, result)
        
    }
    
    mutating func rotate(_ rotationVector: vector_float3 ){
        
        rotate(angle: rotationVector.x, axis: vector_float3(1, 0, 0))
        rotate(angle: rotationVector.y, axis: vector_float3(0, 1, 0))
        rotate(angle: rotationVector.z, axis: vector_float3(0, 0, 1))
        
    }
    
    mutating func rotate(angle: Float, axis: vector_float3) {
        let normalizedAxis = normalize(axis)
        let ct = cosf(angle)
        let st = sinf(angle)
        let ci = 1 - ct
        
        let x = normalizedAxis.x, y = normalizedAxis.y, z = normalizedAxis.z
        
        let result = matrix_float4x4(
            vector_float4(ct + x * x * ci,     y * x * ci + z * st, z * x * ci - y * st, 0),
            vector_float4(x * y * ci - z * st, ct + y * y * ci,     z * y * ci + x * st, 0),
            vector_float4(x * z * ci + y * st, y * z * ci - x * st, ct + z * z * ci,     0),
            vector_float4(0, 0, 0, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    static func perspective(_ fov: Float, _ aspectRatio: Float, _ near: Float, _ far: Float) -> matrix_float4x4 {
        
        // Aspect Ratio
        // Perspective
        // Scale z to normalize.
        
        let fov = fov.toRadians
        
        let t = tan(fov) * 0.5
        
        let x = 1 / ( aspectRatio * t)
        let y = 1 / t
        let z = -(far + near) / (far - near)
        let w = -(2 * far * near) / (far - near)
        
        var result = matrix_identity_float4x4
        
        result.columns.0.x = x
        result.columns.1.y = y
        result.columns.2.z = z
        result.columns.2.w = -1
        result.columns.3.z = w
        
        return result
    }
    
}
