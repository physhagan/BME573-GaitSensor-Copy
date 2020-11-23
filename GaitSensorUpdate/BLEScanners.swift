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
    
//    mutating func appendToGlobal(id: UUID, dataArray: [Int]){
//        for (i,sensor) in availSensors.enumerated() {
//            if sensor.id == id {
//
//            }
//        }
//    }
    
    
    
}







//-----------------------------------------------------------------
//// change to 16 bit uuid   6ce2



// 2 functions add front and add back




// is it good to have scannerName and localName as the same thing?
// for us this is the case, for products this would be different

// divide signal into 2 channels and display 2 channels

// should a total data array be put into the main model so that different "sets" of data can be appended at different times? if there are 2 sets of measurement in a day per say?
// sensor, starting date, data, frequency when data was taken

// make global data array in declaration struct. append to it with mutating function


// save the date and time of a total global array



struct BLESensor: Identifiable {
    var scannerName: String
    var localName: String
    var rssi: Int
    //var peripheral: CBPeripheral
    var id : UUID
    var data: [Int] = []
    var front_foot_data: [Int] = []
    var back_foot_data:[Int] = []
    var totalDataFront: [Int] = []
    var totalDataBack: [Int] = []
}
