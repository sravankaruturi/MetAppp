//
//  MetAppApp.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

import SwiftUI

@main
struct MetAppApp: App {

    init() {
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            Engine.Setup(device: metalDevice)
        }else{
            fatalError("Metal not supported on this device")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                MetalView()
                VStack{
                    HStack{
                        Spacer()
                        Text("Metal App")
                            .padding()
                            .background(Color.white)
                    }
                    Spacer()
                }
            }
        }
        
    }
}
