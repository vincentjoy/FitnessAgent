//
//  ScooterData.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 03/06/25.
//

import Foundation

struct ScooterData: Codable {
    var scooterID: Int
    var scooterName: String
    var scooterModel: String
    var scooterColor: String
    var scooterRange: Int
    var scooterDistanceLeft: Int
    var scooterLat: Int
    var scooterLong: Int
    
    init(dynamicData: ScooterDynamicData, staticData: ScooterStaticData, bluetoothData: BluetoothData?) {
        self.scooterID = staticData.scooterID
        self.scooterName = staticData.scooterName
        self.scooterModel = staticData.scooterModel
        self.scooterColor = staticData.scooterColor
        if let bluetoothData {
            self.scooterRange = bluetoothData.scooterRange
            self.scooterDistanceLeft = bluetoothData.scooterDistanceLeft
        } else {
            self.scooterRange = dynamicData.scooterRange
            self.scooterDistanceLeft = dynamicData.scooterDistanceLeft
        }
        self.scooterLat = dynamicData.scooterLat
        self.scooterLong = dynamicData.scooterLong
    }
}
