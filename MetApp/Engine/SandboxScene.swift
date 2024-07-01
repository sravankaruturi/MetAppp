//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//
import MetalKit

class SandboxScene : EScene {
    
    override func buildScene() {
        
        let count = 5
        
        for y in -count..<count {
            for x in -count..<count {
                let player = Player()
                player.position.y = Float(Float(y) + 0.5)/Float(count)
                player.position.x = Float(Float(x) + 0.5)/Float(count)
                player.scale = SIMD3<Float>(0.1, 0.1, 0.1)
                addChild(player)
            }
        }
        
    }
    
}
