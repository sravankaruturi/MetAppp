//
//  Keyboard.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/30/24.
//
import MetalKit

class SEKeyboard {
    
    private static var keys = Set<UInt16>() // All the pressed keys currently.
    
    public static func SetKeyPressed(_ keyCode: UInt16, isOn: Bool){
        if isOn {
            keys.insert(keyCode)
        } else{
            keys.remove(keyCode)
        }
    }
    
    public static func IsKeyPressed(_ keyCode: UInt16) -> Bool {
        return keys.contains(keyCode)
    }
    
    public static func IsKeyPressed(_ keyCode: SEKeyCode) -> Bool {
        return keys.contains(keyCode.rawValue)
    }
    
}
