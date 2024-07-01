//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//
import MetalKit

class SandboxScene : EScene {
    
    var debugCamera = SEDebugCamera()
    var cube = SECube()
    
    override func buildScene() {
        
        addCamera(debugCamera)
        debugCamera.position.z += 5
        
        addChild(cube)
        
        
    }
    
    override func update(deltaTime: Float) {
        
        cube.rotation.x += deltaTime
        cube.rotation.y += deltaTime
        
        super.update(deltaTime: deltaTime)
        
    }
    
}
