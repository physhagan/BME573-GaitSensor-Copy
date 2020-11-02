//
//  BLEScannerVM.swift
//  GaitSensorUpdate
//
//  Created by Thomas  Hagan on 10/29/20.
//

import SwiftUI
import CoreBluetooth



// CBCentralManagerDelegate:
// NSObject
//      These things are used for Bluetooth properties

class BLEScannerVM: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate  {
    // MARK: - Set-up model connection, make window to model, set-up bluetooth, return data
    @Published private var scannerdata: BLESensors = createBLESensors()
    var centralManager : CBCentralManager!  // centralManager will "manage" the bluetooth peripherals
                                            // this is an optional so there's an !
    
    static func createBLESensors() -> BLESensors {  // "static" means this applies to all instances
        return BLESensors()                         // of BLESensors
    }
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)   // delegate says that this class
    }                                                                    // will handle all bluetooth
                                                                        // stuff
    // MARK: - VM Access to data in BLEScanners
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
        //if centralManager.state == .poweredOn {
            //centralManager.scanForPeripherals(withServices: [], options: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {  // this sets the timer for scanning
                print("stop scanning")
                self.centralManager.stopScan()
            }
        }
    // withServices: [pressure_service_uuid]
    
    //}
    
    // if you want to connect to a certain sensor after seeing that it exists
    func connect(peripheral: BLESensor) {
        print("called connect...")
        // This is where a peripheral is assigned
        
        //peripheral.peripheral.delegate = self
        //centralManager.connect(peripheral.peripheral, options:nil)
    }
    
    
    // disconnect from a peripheral and then save the data to storage
    func disconnect(peripheral: BLESensor) {
        var dataString: String = ""
        print("disconnect...")
        //centralManager.cancelPeripheralConnection(peripheral.peripheral)
        print("data count: \(peripheral.data.count)")
        for dataPoint in peripheral.data {
            dataString = dataString + "\(dataPoint) \n"
        }

        let fileURL = URL(fileURLWithPath: "data", relativeTo: getDocumentsDirectory()).appendingPathExtension("txt")
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

    
    // ----------------------------------------------------------------------
    // MARK: - Bluetooth
    
    // this shows that bluetooth is on or not
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("DidUpdateState called")
        if central.state == .poweredOn {
            print("BLE working")
        } else {
            print("ERROR: BLE is not working")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("\(peripheral.name ?? "nothing") rssi:\(RSSI)")
        print("local name: \(advertisementData["kCBAdvDataLocalName"] ?? "no local name")")
        print("uuid: \(peripheral.identifier)")
        scannerdata.addscanner(scannerName: peripheral.name ?? "noname",
                                   localName: (advertisementData["kCBAdvDataLocalName"] ?? "no local name") as! String,
                                    rssi: Int(truncating: RSSI),
                                    peripheral:peripheral,
                                    uuid: peripheral.identifier)
    }
    // "falling down the rabbit hole" of connecting to a BLE device
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("peripheral connected: \(peripheral)")
        peripheral.discoverServices([pressure_service_uuid])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("service discovered:")
        if let services = peripheral.services {
            for service in services {
                print("\(service)")
                peripheral.discoverCharacteristics([pressure_char_uuid], for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("characteristic discovered")
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("characteristic: \(characteristic)")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //print(characteristic.value!.hexEncodedString())
        var first: Bool = true
        var sensorValue: Int = 0
        if let values = characteristic.value {
            values.forEach { (digit) in
                if first {
                    sensorValue = Int(digit)
                    first = false
                } else {
                    sensorValue = sensorValue + Int(digit)*256
                    scannerdata.adddata(id: peripheral.identifier, sensorData: sensorValue)
                    first = true
                }
            }
        }
    }
    
    let pressure_char_uuid = CBUUID(string:"5A8AC39C-0CE1-4212-8B46-D589BA126CE2")
    let period_char_uuid = CBUUID(string:"F8BC0798-E447-4625-959F-CE6970B70ED1")
    let pressure_service_uuid = CBUUID(string:"573BC605-1C3C-4467-B4AA-44E0C6C6B410")

}
