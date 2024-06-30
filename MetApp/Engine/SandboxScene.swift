//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//
import MetalKit

class SandboxScene : EScene {
    
    let entity: Entity = Player()
    let entity2: Entity = Player()
    
    override func buildScene() {
        
        for y in -5..<5 {
            for x in -5..<5 {
                let player = Player()
                player.position.y = Float(Float(y) + 0.5)/5
                player.position.x = Float(Float(x) + 0.5)/5
                player.scale = SIMD3<Float>(0.1, 0.1, 0.1)
                addChild(player)
            }
        }
        
    }
    
    override func update(deltaTime: Float) {
        for child in children {
            child.rotation.z += 0.02
        }
        
        super.update(deltaTime: deltaTime)
    }
    
}
