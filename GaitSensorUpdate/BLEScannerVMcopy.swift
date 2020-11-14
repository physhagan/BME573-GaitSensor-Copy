//
//  BLEScannerVMcopy.swift
//  GaitSensorUpdate
//
//  Created by Thomas  Hagan on 11/3/20.
//

import SwiftUI
//import CoreBluetooth

//class BLEScannerVM: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
class BLEScannerVM: ObservableObject {
    
    @Published private var scannerdata: BLESensors = createBLESensors()
    //var fakedatastruck:
    //var centralManager : CBCentralManager!
    
    static func createBLESensors() -> BLESensors {
        return BLESensors()
    }
    
//    override init() {
//        super.init()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
    
    // MARK: - Access to data
    var blesensors: [BLESensor] {
        return scannerdata.availSensors
    }
    
    func bledata(uuid:UUID) -> [Int] {
        for (i,sensor) in scannerdata.availSensors.enumerated() {
            if sensor.id == uuid {
               return scannerdata.availSensors[i].data
            }
        }
        return []
    }
    
    // MARK: - Intents
    func scan() {
        print("scanning...")
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Ball Sensor"]!.scannerName,
                               localName: fakeSensorDictionary["Ball Sensor"]!.localName,
                               rssi: fakeSensorDictionary["Ball Sensor"]!.rssi,
                               uuid: fakeSensorDictionary["Ball Sensor"]!.id)
        
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Heel Sensor"]!.scannerName,
                               localName: fakeSensorDictionary["Heel Sensor"]!.localName,
                               rssi: fakeSensorDictionary["Heel Sensor"]!.rssi,
                               uuid: fakeSensorDictionary["Heel Sensor"]!.id)
// Cutting out the bluetooth dependence:
//        if centralManager.state == .poweredOn {
//            centralManager.scanForPeripherals(withServices: [], options: nil)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                print("stop scanning")
//                self.centralManager.stopScan()
//            }
//        }
    }
    
    // withServices: [pressure_service_uuid]
    
    
    
    func connect(peripheral: BLESensor) {

        print("called connect...")
        //peripheral.peripheral.delegate = self
        //centralManager.connect(peripheral.peripheral, options:nil)
        print("The peripheral is: \(peripheral)")
//
//        var first: Bool = true
//        var sensorValue: Int = 0
        if peripheral.localName == "Ball Sensor" {
            let characteristic = fakeData
            
            let values = characteristic
                values.forEach { (digit) in
                    scannerdata.adddata(id: peripheral.id, sensorData: Int(digit))
                }
        }
        
        if peripheral.localName == "Heel Sensor" {
            let characteristic = fakeData2
            
            let values = characteristic
                values.forEach { (digit) in
                    scannerdata.adddata(id: peripheral.id, sensorData: Int(digit))
                }
        }
        
        
        //print(characteristic[0..<9])//.hexEncodedString())
//        let values = characteristic
//            values.forEach { (digit) in
//                scannerdata.adddata(id: peripheral.id, sensorData: Int(digit))
//            }
                    
                    //if first {
//                        sensorValue = Int(digit)
//                        first = false
//                    } else {
//                        sensorValue = sensorValue + Int(digit)
//                        scannerdata.adddata(id: peripheral.id, sensorData: sensorValue)
//                        first = true
//                    }
                
            // create a timer to start when you connect
            // 
        
    }
    
    
    
    
    
    
    func disconnect(peripheral: BLESensor) {
        var dataString: String = ""
        print("disconnect...")
        //centralManager.cancelPeripheralConnection(peripheral.peripheral)
        //print("The sensor is: \(peripheral.data.count)")
        print("data count: not there yet")
        for dataPoint in peripheral.data {
            dataString = dataString + "\(dataPoint) \n"
        }

        let fileURL = URL(fileURLWithPath: String(peripheral.localName), relativeTo: getDocumentsDirectory()).appendingPathExtension("txt")
        do {
            try dataString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            print("saving data...")
        } catch {
            print("something went wrong writing the data")
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // MARK: - Bluetooth
    // This checks if bluetooth is turned on.
    
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        print("DidUpdateState called")
//        if central.state == .poweredOn {
//            print("BLE working")
//        } else {
//            print("ERROR: BLE is not working")
//        }
//    }
    
    
    
    // This
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print("\(peripheral.name ?? "nothing") rssi:\(RSSI)")
//        print("local name: \(advertisementData["kCBAdvDataLocalName"] ?? "no local name")")
//        print("uuid: \(peripheral.identifier)")
//        scannerdata.addscanner(scannerName: peripheral.name ?? "noname",
//                                   localName: (advertisementData["kCBAdvDataLocalName"] ?? "no local name") as! String,
//                                    rssi: Int(truncating: RSSI),
//                                    peripheral:peripheral,
//                                    uuid: peripheral.identifier)
//    }
    
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("peripheral connected: \(peripheral)")
//        peripheral.discoverServices([pressure_service_uuid])
//    }
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        print("service discovered:")
//        if let services = peripheral.services {
//            for service in services {
//                print("\(service)")
//                peripheral.discoverCharacteristics([pressure_char_uuid], for: service)
//            }
//        }
//    }
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        print("characteristic discovered")
//        if let characteristics = service.characteristics {
//            for characteristic in characteristics {
//                print("characteristic: \(characteristic)")
//                peripheral.setNotifyValue(true, for: characteristic)
//            }
//        }
//    }
    
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        print(characteristic.value!.hexEncodedString())
//        var first: Bool = true
//        var sensorValue: Int = 0
//        if let values = characteristic.value {
//            values.forEach { (digit) in
//                if first {
//                    sensorValue = Int(digit)
//                    first = false
//                } else {
//                    sensorValue = sensorValue + Int(digit)*256
//                    scannerdata.adddata(id: peripheral.identifier, sensorData: sensorValue)
//                    first = true
//                }
//            }
//        }
//    }
    
//    let pressure_char_uuid = CBUUID(string:"5A8AC39C-0CE1-4212-8B46-D589BA126CE2")
//    let period_char_uuid = CBUUID(string:"F8BC0798-E447-4625-959F-CE6970B70ED1")
//    let pressure_service_uuid = CBUUID(string:"573BC605-1C3C-4467-B4AA-44E0C6C6B410")

}
