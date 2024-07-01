//
//  Player.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Pointer : Entity {
    
    init() {
        
        super.init(meshType: .Triangle_Custom)
        
    }
    
    override func update(deltaTime: Float) {
        
        self.rotation.z = -atan2(SEMouse.GetMouseViewportPosition().x - position.x, SEMouse.GetMouseViewportPosition().y - position.y)
        
        super.update(deltaTime: deltaTime)
        
    }
    
}
