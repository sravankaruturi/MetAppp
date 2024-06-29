//
//  Types.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

protocol sizeable {
    
    static func size(_ count: Int ) -> Int
    static func stride(_ count: Int) -> Int
    
}

extension sizeable {
    
    static func size() -> Int {
        return MemoryLayout<Self>.size
    }
    
    static func stride() -> Int {
        return MemoryLayout<Self>.stride
    }
    
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
    
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size
    }
    
}

struct Vertex : sizeable {
    
    var position: SIMD3<Float>
    var color: SIMD4<Float>
    
}

extension SIMD3 : sizeable {
    
    
    
}
