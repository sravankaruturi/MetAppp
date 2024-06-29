//
//  Renderable.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

protocol Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
    
}
