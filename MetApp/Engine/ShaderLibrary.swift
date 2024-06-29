//
//  ShaderLibrary.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

enum VertexShaderTypes  {
    
    case Basic
    
}

enum FragmentShaderTypes {
    
    case Basic
}

class ShaderLibrary {
    
    public static var DefaultLibrary: MTLLibrary!
    
    private static var vertexShaders : [VertexShaderTypes: Shader] = [:]
    private static var fragmentShaders : [FragmentShaderTypes: Shader] = [:]
    
    public static func setup() {
        
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
        
    }
    
    public static func createDefaultShaders() {
        
        vertexShaders[.Basic] = Basic_VertexShader()
        fragmentShaders[.Basic] = Basic_FragmentShader()
        
    }
    
    public static func getVertexShaderFunction(_ type: VertexShaderTypes) -> MTLFunction {
        return vertexShaders[type]!.function
    }
    
    public static func getFragmentShaderFunction(_ type: FragmentShaderTypes) -> MTLFunction {
        return fragmentShaders[type]!.function
    }
    
}

protocol Shader {
    
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
    
}

public struct Basic_VertexShader: Shader {
    
    public var name: String = "Basic Vertex Shader"
    
    public var functionName: String = "basic_vertex_shader"
    
    public var function: MTLFunction {
        
        let function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
        
    }
    
}

public struct Basic_FragmentShader: Shader {
    
    public var name: String = "Basic Fragment Shader"
    
    public var functionName: String = "basic_fragment_shader"
    
    public var function: MTLFunction {
        let function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
    }
}
