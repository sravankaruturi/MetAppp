//
//  SECameraManager.swift
//  MetApp
//
//  Created by Sravan Karuturi on 7/1/24.
//


// Strategy Patterns

class SECameraManager {
    
    private var _cameras: [SECameraTypes: SECamera] = [:]
    
    public var currentCamera: SECamera!
    
    public func registerCamera(_ camera: SECamera) {
        self._cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: SECameraTypes) {
        self.currentCamera = _cameras[cameraType]
    }
    
    internal func update(deltaTime: Float){
        for camera in _cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
    
}
