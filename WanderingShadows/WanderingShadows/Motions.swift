//
//  Motions.swift
//  WanderingShadows
//
//  Created by Thomas Schatton on 25.06.22.
//

import Foundation
import CoreMotion

class Motions: ObservableObject {
    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    @Published var xRot: Double = 0.0
    @Published var yRot: Double = 0.0
    
    private let motion = CMMotionManager()
    let timer = Timer.publish(every: (1.0 / 60.0), on: .main, in: .common).autoconnect()
    
    init() {
        print("Motions.init")
        if motion.isDeviceMotionAvailable {
            print("DeviceMotion is available")
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.startDeviceMotionUpdates()
        } else {
            print("DeviceMotion is NOT available")
        }
    }
    
    func startMotions() {
        if motion.isDeviceMotionAvailable && !motion.isDeviceMotionActive {
            motion.startDeviceMotionUpdates()
        }
    }
    
    func stopMotions() {
        if motion.isDeviceMotionAvailable && motion.isDeviceMotionActive {
            motion.stopDeviceMotionUpdates()
        }
    }
    
    func updateShadows() {
        guard let currentForces = motion.deviceMotion?.gravity else { return }
        
        x = currentForces.x * 25
        y = currentForces.y * -25
        
        xRot = currentForces.x * -15
        yRot = currentForces.y * -15
    }
}
