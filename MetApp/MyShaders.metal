//
//  MyShaders.metal
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 vertex_shader( constant simd_float3 *vertices[[buffer(0)]], uint vertexID [[vertex_id]] ){
    
    return float4(vertices[vertexID], 1);
    
}

fragment half4 fragment_shader() {
    
    return half4(1);
    
}
