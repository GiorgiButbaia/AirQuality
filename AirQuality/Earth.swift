//
//  Earth.swift
//  AirQuality
//
//  Created by Giorgi Butbaia on 5/31/20.
//  Copyright © 2020 Etherlabs. All rights reserved.
//

import Foundation
import SceneKit

class Earth : SCNNode {
    public let RADIUS: CGFloat

    init(radius: CGFloat) {
        RADIUS = radius
        super.init()
        self.geometry = SCNSphere(radius: radius)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Diffuse")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named:"Specular")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named:"Emission")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named:"Normal")
        self.geometry?.firstMaterial?.isDoubleSided = true

        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50

        // Action for rotation
        // let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x:0, y:1, z:0), duration: 8)
        // let repeatAction = SCNAction.repeatForever(action)
        // self.runAction(repeatAction)
    }
    
    convenience override init() {
        self.init(radius: 0.05)
    }

    required init?(coder: NSCoder) {
        RADIUS = 0.05
        super.init(coder: coder)
    }
}
