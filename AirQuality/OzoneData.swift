//
//  OzoneData.swift
//  AirQuality
//
//  Created by Giorgi Butbaia on 5/31/20.
//  Copyright © 2020 Etherlabs. All rights reserved.
//

import Foundation

struct OzoneEntry {
    // Coordinates
    var theta: Double
    var phi: Double
    
    // Value
    var value: Double
}

class OzoneData {
    // Contains all Ozone entries
    private let ozoneEntries: [OzoneEntry]
    
    /**
     * Stub initializer.
     * Populates ozoneEntries
     */
    init() {
        ozoneEntries = [
            OzoneEntry(theta: 0, phi: 0, value: 300),
            OzoneEntry(theta: 0.57, phi: 0, value: 305),
            OzoneEntry(theta: 0.1, phi: 0.3, value: 295)
        ]
    }
    
    /**
     * @returns all ozone entries.
     */
    func getData() -> [OzoneEntry] {
        return ozoneEntries;
    }
}
