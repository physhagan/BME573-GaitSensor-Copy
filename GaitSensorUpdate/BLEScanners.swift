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
    
    mutating func addFrontData(id: UUID, sensorData:Double) {
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                availSensors[i].front_foot_data.append(sensorData)
            }
            else{}
        }
    }
    
    mutating func addBackData(id: UUID, sensorData:Double) {
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                availSensors[i].back_foot_data.append(sensorData)
            }
            else{}
        }
    }
    
    mutating func remToeData(id: UUID){
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                print("Toe Before:")
                print(availSensors[i].front_foot_data.count)
                availSensors[i].front_foot_data.removeAll()
                print("Toe After")
                print(availSensors[i].front_foot_data.count)
            break
            }
        }
        
    }
    mutating func remHeelData(id: UUID){
            for (i,sensor) in availSensors.enumerated() {
                if sensor.id == id {
                    print("Heel Before:")
                    print(availSensors[i].back_foot_data.count)
                    availSensors[i].back_foot_data.removeAll()
                    print("Heel After:")
                    print(availSensors[i].back_foot_data.count)
                break
            }
        }
    }
    
    
    mutating func appendToAllToe(id: UUID, dataArray: [Double]){
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                availSensors[i].totalDataFront.append(contentsOf: dataArray)
                print(availSensors[i].totalDataFront.count)
            break
            }
        }
    }
    mutating func appendToAllHeel(id: UUID, dataArray: [Double]){
        for (i,sensor) in availSensors.enumerated() {
            if sensor.id == id {
                availSensors[i].totalDataBack.append(contentsOf: dataArray)
                print(availSensors[i].totalDataBack.count)
            break
            }
            else{}
        }
    }
    
    
}







//-----------------------------------------------------------------
//// change to 16 bit uuid   6ce2



// 2 functions add front and add back (x)


// sensor, starting date, data, frequency when data was taken (x)

// make global data array in declaration struct. append to it with mutating function


// save the date and time of a total global array (x)



struct BLESensor: Identifiable {
    var scannerName: String
    var localName: String
    var rssi: Int
    //var peripheral: CBPeripheral
    var id : UUID
    //var data: [Int] = []
    var front_foot_data: [Double] = []
    var back_foot_data:[Double] = []
    var totalDataFront: [Double] = []
    var totalDataBack: [Double] = []
}
