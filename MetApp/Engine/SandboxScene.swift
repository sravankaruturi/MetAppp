//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//
import MetalKit

class SandboxScene : EScene {
    
    var debugCamera = SEDebugCamera()
    
    override func buildScene() {
        
        addCamera(debugCamera)
        debugCamera.position.z += 5
        
        addCubes()
        
        
    }
    
    override func update(deltaTime: Float) {
        
        super.update(deltaTime: deltaTime)
        
    }
    
    func addCubes(){
        
        for y in -5..<5{
            let posy = Float(y) + 0.5
            
            for x in -5..<5{
                
                let posX = Float(x) + 0.5
                
                let cube = SECube()
                cube.position.x = posX
                cube.position.y = posy
                cube.position.z = 0
                
                cube.scale = SIMD3<Float>(repeating: 0.3)
                cube.setColor(SIMD4<Float>(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1))
                
                addChild(cube)
                
            }
            
        }
        
    }
    
}
