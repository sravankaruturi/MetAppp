//
//  RenderPipeLineDescriptorLibrary.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

enum RenderPipeLineDescriptorType {
    case Basic
}

protocol RenderPipeLineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! { get }
}

class RenderPipeLineDescriptorLibrary {
    
    private static var renderPipleLineDescriptors: [RenderPipeLineDescriptorType: RenderPipeLineDescriptor] = [:]
    
    public static func getRenderPipeLineDescriptor(_ type: RenderPipeLineDescriptorType) -> MTLRenderPipelineDescriptor {
        return renderPipleLineDescriptors[type]!.renderPipelineDescriptor
    }
    
    private static func createDefaultRenderPipelineDescriptors() {
        renderPipleLineDescriptors[.Basic] = BasicRenderPipeLineDescriptor()
    }
    
    public static func setup(){
        createDefaultRenderPipelineDescriptors()
    }
    
}

public class BasicRenderPipeLineDescriptor: RenderPipeLineDescriptor {
    
    public var name: String {
        return "BasicRenderPipeLineDescriptor"
    }
    
    public var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    public init(){
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Prefs.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.getVertexShaderFunction(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.getFragmentShaderFunction(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.GetVertexDescriptor(.Basic)
    }
    
}
