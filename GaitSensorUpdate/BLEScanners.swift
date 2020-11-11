//
//  BLEScanners.swift
//  GaitSensorUpdate
//
//  Created by Thomas  Hagan on 10/29/20.
//

import Foundation
//import CoreBluetooth

struct BLESensors {
    var availSensors: [BLESensor] = []
    
    mutating func addscanner(scannerName:String,localName:String,rssi:Int,uuid:UUID){
        var matched : Bool = false
        for sensor in availSensors {
            if (sensor.scannerName == scannerName) &&
                (sensor.localName == localName) {
                matched = true
                break
            }
        }
        if !matched {
            availSensors.append(BLESensor(scannerName:scannerName,
                                            localName:localName,
                                            rssi:rssi,
                                            id:uuid))

        }
    }
    
    mutating func adddata(id: UUID, sensorData:Int) {
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                availSensors[i].data.append(sensorData)
                break
            }
        }
    }
}

struct BLESensor: Identifiable {
    var scannerName: String
    var localName: String
    var rssi: Int
    //var peripheral: CBPeripheral
    var id : UUID
    var data: [Int] = []
}
