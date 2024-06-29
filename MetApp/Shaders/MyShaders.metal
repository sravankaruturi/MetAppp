//
//  MyShaders.metal
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

#include <metal_stdlib>
using namespace metal;

struct vertexIn{
    simd_float3 position [[ attribute(0) ]] ;
    simd_float4 color [[ attribute(1) ]];
};

struct RasterizerData {
    simd_float4 position [[ position ]];
    simd_float4 color;
};

vertex RasterizerData basic_vertex_shader( const vertexIn vIn [[ stage_in ]]){
    
    RasterizerData rd;
    rd.position = float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
    
}



fragment half4 basic_fragment_shader( RasterizerData rd [[ stage_in ]] ) {
    
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
    
}