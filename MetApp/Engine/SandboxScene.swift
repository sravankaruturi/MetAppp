//
//  SandboxScene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

class SandboxScene: Scene {
    
    var entity: Entity = Player()
    
    override func buildScene() {
        
        addChild(entity)
        
    }
    
}
