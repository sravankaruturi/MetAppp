//
//  RenderPipelineStateLibrary.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

enum RenderPipelineStateType {
    case Basic
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

class RenderPipelineStateLibrary {
    
    private static var renderPipelineStates: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    public static func setup() {
        createDefaultRenderPipelineStates()
    }
    
    private static func createDefaultRenderPipelineStates() {
        renderPipelineStates[.Basic] = BasicRenderPipelineState()
    }
    
    public static func getRenderPipelineState(_ type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return renderPipelineStates[type]!.renderPipelineState
    }
    
}

public class BasicRenderPipelineState: RenderPipelineState {
    
    public var name = "BasicRenderPipelineState"
    public var renderPipelineState: MTLRenderPipelineState!
    
    public init(){
        
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: RenderPipeLineDescriptorLibrary.getRenderPipeLineDescriptor(.Basic))
        }catch{
            print("ERROR::CREATE::RENDER PIPELINE STATE::__\(name)__::\(error)")
        }
        
    }
    
}
