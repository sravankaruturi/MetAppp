//
//  Ext+Float.swift
//  MetApp
//
//  Created by Sravan Karuturi on 7/1/24.
//

extension Float {
    
    var toRadians : Float {
        return ( self.magnitude / 180.0 ) * Float.pi
    }
    
    var toDegrees : Float {
        return self.magnitude * 180.0 / Float.pi
    }
    
}
