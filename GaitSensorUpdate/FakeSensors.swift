//
//  ListOfSensors.swift
//  GaitSensorUpdate
//
//  Created by Thomas  Hagan on 11/3/20.
//

import Foundation
//import CoreBluetooth

struct fakeSensor: Identifiable {
    let id = UUID()
    let scName: String
    let locName: String
    let rssi: Int
}
