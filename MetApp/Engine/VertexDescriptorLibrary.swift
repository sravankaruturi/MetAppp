//
//  VertexDescriptorLibrary.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

enum VertexDescriptorType {
    case Basic
}

class VertexDescriptorLibrary {
    
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func setup() {
        createDefaultVertexDescriptors()
    }
    
    public static func createDefaultVertexDescriptors() {
        vertexDescriptors[.Basic] = BasicVertexDescriptor()
    }
    
    public static func GetVertexDescriptor(_ type: VertexDescriptorType) -> MTLVertexDescriptor {
        return vertexDescriptors[type]!.vertexDescriptor
    }
    
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor! { get }
}

public struct BasicVertexDescriptor: VertexDescriptor {
    public var name = "BasicVertexDescriptor"
    public var vertexDescriptor: MTLVertexDescriptor!
    
    public init(){
        
        vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size()
        
        vertexDescriptor.layouts[0].stride = Vertex.stride()
        
    }
}
