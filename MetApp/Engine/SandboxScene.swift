//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//
import MetalKit

class SandboxScene : EScene {
    
    let entity: Entity = Player()
    
    override func buildScene() {
        
        self.addChild(entity)
        
    }
    
}
