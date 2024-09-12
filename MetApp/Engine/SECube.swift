//
//  SECube.swift
//  MetApp
//
//  Created by Sravan Karuturi on 7/1/24.
//

import MetalKit

class SECube : Entity {
    
    init() {
        super.init(meshType: .Cube_Custom)
    }
    
    override func update(deltaTime seconds: Float) {
        
        self.rotation.x += Float.random(in: 0...1) * seconds
        self.rotation.y += Float.random(in: 0...1) * seconds
        
        super.update(deltaTime: seconds)
        
    }
    
}
