//
//  MetalView.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

import MetalKit
import SwiftUI


struct MetalView: NSViewRepresentable {
    
    func makeCoordinator() -> Renderer {
        Renderer()
    }
    
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> SEGameView {
        
        let gameView = SEGameView()
        
        gameView.delegate = context.coordinator
        
        gameView.preferredFramesPerSecond = 60
        gameView.enableSetNeedsDisplay = false
        gameView.device = Engine.Device
        
        gameView.framebufferOnly = false
        
        gameView.clearColor = Prefs.ClearColor
        gameView.depthStencilPixelFormat = Prefs.MainDepthPixelFormat
        
        gameView.drawableSize = gameView.frame.size
        
        return gameView
        
    }
    
    func updateNSView(_ nsView: SEGameView, context: NSViewRepresentableContext<MetalView>) {
        
    }
}
