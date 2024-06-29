//
//  MeshLibrary.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

enum MeshTypes {
    case Triangle_Custom
    case Rectangle_Custom
}

class MeshLibrary {
    
    private static var meshes: [MeshTypes: Mesh] = [:]
    
    public static func setup() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(TriangleMesh(), forKey: .Triangle_Custom)
        meshes.updateValue(QuadMesh(), forKey: .Rectangle_Custom)
    }
    
    public static func getMesh(_ type: MeshTypes) -> Mesh {
        return meshes[type]!
    }
    
}

protocol Mesh {
    
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
    func createBuffers(device: MTLDevice)
    
}

class CustomMesh : Mesh {
    
    var vertices: [Vertex]!
    
    var vertexBuffer: (any MTLBuffer)!
    var vertexCount: Int! {
        return vertices.count
    }
    
    init() {
        createVertices()
    }
    
    func createVertices() { }
    
    public func createBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: Vertex.size() * vertices.count, options: [])
    }
}

class TriangleMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: [0, 1, 0], color: [1, 0, 0, 1]),
            Vertex(position: [-1, -1, 0], color: [0, 1, 0, 1]),
            Vertex(position: [1, -1, 0], color: [0, 0, 1, 1])
        ]
    }
}

class QuadMesh: CustomMesh {
    override func createVertices() {
        vertices = [
            Vertex(position: [ 0.5,  0.5, 0], color: [1, 0, 0, 1]),
            Vertex(position: [-0.5,  0.5, 0], color: [0, 1, 0, 1]),
            Vertex(position: [-0.5, -0.5, 0], color: [0, 0, 1, 1]),
            
            Vertex(position: [ 0.5,  0.5, 0], color: [1, 0, 0, 1]),
            Vertex(position: [-0.5, -0.5, 0], color: [0, 0, 1, 1]),
            Vertex(position: [ 0.5, -0.5, 0], color: [1, 0, 1, 1])
        ]
    }
}
