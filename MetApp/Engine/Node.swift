//
//  Node.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class Node {
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder ) {
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
        
    }
    
}
