//
//  SEDebugCamera.swift
//  MetApp
//
//  Created by Sravan Karuturi on 7/1/24.
//
import simd

class SEDebugCamera : SECamera {
    
    var cameraType: SECameraTypes = .Debug
    
    var position: SIMD3<Float> = SIMD3<Float>(0, 0, 0)
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(45, Renderer.AspectRatio, 0.1, 100)
    }
    
    func update(deltaTime: Float) {
        
        if SEKeyboard.IsKeyPressed(.w) {
            self.position.y += deltaTime
        }
        
        if SEKeyboard.IsKeyPressed(.a) {
            self.position.x -= deltaTime
        }
        
        if SEKeyboard.IsKeyPressed(.s) {
            self.position.y -= deltaTime
        }
        
        if SEKeyboard.IsKeyPressed(.d) {
            self.position.x += deltaTime
        }
        
    }

}
