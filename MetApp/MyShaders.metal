//
//  MyShaders.metal
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

#include <metal_stdlib>
using namespace metal;

struct vertexIn{
    simd_float3 position;
    simd_float4 color;
};

struct RasterizerData {
    simd_float4 position [[ position ]];
    simd_float4 color;
};

vertex RasterizerData vertex_shader( constant vertexIn *vertices[[buffer(0)]], uint vertexID [[vertex_id]] ){
    
    RasterizerData rd;
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    return rd;
    
}



fragment half4 fragment_shader( RasterizerData rd [[ stage_in ]] ) {
    
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
    
}
