//
//  Scene.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/29/24.
//

import MetalKit

class EScene : Node {
    
    var sceneConstants = SceneConstants()
    var cameraManager = SECameraManager()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(_ camera: SECamera, isCurrent: Bool = true){
        cameraManager.registerCamera(camera)
        if isCurrent {
            cameraManager.setCamera(camera.cameraType)
        }
    }
    
    func updateSceneConstants() {
        sceneConstants.viewMatrix = cameraManager.currentCamera.viewMatrix
    }
    
    func updateCameras(deltaTime: Float) {
        cameraManager.update(deltaTime: deltaTime)
    }
    
    override func update(deltaTime: Float) {
        updateCameras(deltaTime: deltaTime)
        updateSceneConstants()
        super.update(deltaTime: deltaTime)
        
    }
    
    override func render(renderCommandEncoder: any MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride(), index: 1)
        
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}
