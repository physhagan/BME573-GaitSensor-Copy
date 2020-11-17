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
    
//    mutating func appenddata(id: UUID, dataArray: [Int]){
//        for (i,sensor) in availSensors.enumerated() {
//            if sensor
//        }
//    }
    
    
    
}

//// change to 16 bit uuid

// is it good to have scannerName and localName as the same thing?
// for us this is the case, for products this would be different

// should a total data array be put into the main model so that different "sets" of data can be appended at different times? if there are 2 sets of measurement in a day per say?
// sensor, starting date, data, frequency when data was taken


struct BLESensor: Identifiable {
    var scannerName: String
    var localName: String
    var rssi: Int
    //var peripheral: CBPeripheral
    var id : UUID
    var data: [Int] = []
    var totalDataArray: [Int] = []
}
