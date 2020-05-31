//
//  EarthData.swift
//  AirQuality
//
//  Created by Giorgi Butbaia on 5/31/20.
//  Copyright © 2020 Etherlabs. All rights reserved.
//

import Foundation
import SceneKit

class EarthData {
    // Background earth model
    let earth_model: Earth
    let ozone_data: OzoneData

    init() {
        earth_model = Earth()
        earth_model.position = SCNVector3Make(0, 0, 0)

        ozone_data = OzoneData()
    }
    
    /**
     * Draws text at specified position
     * @param point: Position
     * @param text: The text.
     */
    class func createText(_ point: Point, text: String) -> SCNNode {
        let text = SCNText(string: text, extrusionDepth: 1.0)
        text.firstMaterial?.diffuse.contents = UIColor.white

        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3((0.01/2)/10, (0.01/2)/10.0, (0.001)/10.0)
        textNode.position = SCNVector3(
            point.x, point.y, point.z)
        SCNGeometry.center(node: textNode)
        
        return textNode
    }
    
    /**
     * @returns: an array of SCNNodes representation
     * of the EarthData.
     */
    func render() -> [SCNNode] {
        var nodes: [SCNNode] = []
        nodes.append(earth_model)
        
        for entry in ozone_data.getData() {
            nodes.append(EarthData.createText(
                Point(x: (Double(earth_model.RADIUS) + 0.03) * cos(entry.theta) * cos(entry.phi),
                      y: (Double(earth_model.RADIUS) + 0.03) * sin(entry.theta) * cos(entry.phi),
                      z: (Double(earth_model.RADIUS) + 0.03) * sin(entry.phi)), text: "Ozone: \(entry.value) DU"))
        }

        return nodes
    }
}

extension SCNGeometry {
    class func center(node: SCNNode) {
        let (min, max) = node.boundingBox

        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
    }

    class func magnitude(_ vector: SCNVector3) -> Float {
        return sqrt(
            vector.x * vector.x +
            vector.y * vector.y +
            vector.z * vector.z)
    }

    class func findDistance(_ from: SCNVector3, _ to: SCNVector3) -> Float {
        // Initialize vector
        let vector = SCNVector3(
            to.x - from.x,
            to.y - from.y,
            to.z - from.z)
        let distance = magnitude(vector)
        return distance
    }

    class func drawCylinder(from: SCNVector3, to: SCNVector3) -> SCNNode {
        // Compute the length of the vector
        let distance = findDistance(from, to)

        // Find middle of the vector
        let middle = SCNVector3(
            (to.x + from.x) / 2,
            (to.y + from.y) / 2,
            (to.z + from.z) / 2)

        // Initialize line geometry
        let cylinder = SCNCylinder()
        cylinder.radius = 0.005
        cylinder.height = CGFloat(distance)
        cylinder.radialSegmentCount = 5

        // Create material
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemPink
        material.lightingModel = .phong
        cylinder.firstMaterial = material

        // Create node
        let node = SCNNode(geometry: cylinder)
        node.position = middle
        node.eulerAngles = SCNVector3Make(
            Float(Double.pi / 2),
            acos((to.z - from.z)/distance),
            atan2(to.y - from.y,
                  to.x - from.x))
        return node
    }
}

