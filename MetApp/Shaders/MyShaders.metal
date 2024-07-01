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

struct ModelConstants {

    float4x4 modelMatrix;
    
};

struct SceneConstants {
    
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
    
};

vertex RasterizerData basic_vertex_shader( const vertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    
    RasterizerData rd;
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
    
}



fragment half4 basic_fragment_shader( RasterizerData rd [[ stage_in ]] ) {
    
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
    
}
