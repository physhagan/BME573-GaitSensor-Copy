//
//  BLEScannerVMcopy.swift
//  GaitSensorUpdate
//
//  Created by Thomas  Hagan on 11/3/20.
//

import SwiftUI
//import CoreBluetooth

//class BLEScannerVM: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
class BLEScannerVM: UIViewController, ObservableObject {
    
    @Published private var scannerdata: BLESensors = createBLESensors()
    
    @objc func timerFired(){
        print("The timer was called.")
        
        
        
    }
    
    
    
    //var fakedatastruck:
    //var centralManager : CBCentralManager!
    
    // MARK: - Timer Information
    var timer: Timer!
    var fakeDataIndex = 0
    var timer1: Timer!
    var fakeDataIndex1 = 0
    
    
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
    
//    func bledata(uuid:UUID) -> [Int] {
//        for (i,sensor) in scannerdata.availSensors.enumerated() {
//            if sensor.id == uuid {
//               return scannerdata.availSensors[i].data
//            }
//        }
//        return []
//    }
    
    func bledataFront(uuid:UUID) -> [Double] {
        for (i,sensor) in scannerdata.availSensors.enumerated() {
            if sensor.id == uuid {
               return scannerdata.availSensors[i].front_foot_data
            }
        }
        return []
    }
    
    func bledataBack(uuid:UUID) -> [Double] {
        for (i,sensor) in scannerdata.availSensors.enumerated() {
            if sensor.id == uuid {
               return scannerdata.availSensors[i].back_foot_data
            }
        }
        return []
    }
    
    
    // MARK: - Intents
    func scan() {
        print("scanning...")
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Sensor1"]!.scannerName,
                               localName: fakeSensorDictionary["Sensor1"]!.localName,
                               rssi: fakeSensorDictionary["Sensor1"]!.rssi,
                               uuid: fakeSensorDictionary["Sensor1"]!.id)
        
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Sensor2"]!.scannerName,
                               localName: fakeSensorDictionary["Sensor2"]!.localName,
                               rssi: fakeSensorDictionary["Sensor2"]!.rssi,
                               uuid: fakeSensorDictionary["Sensor2"]!.id)
        
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Sensor3"]!.scannerName,
                               localName: fakeSensorDictionary["Sensor3"]!.localName,
                               rssi: fakeSensorDictionary["Sensor3"]!.rssi,
                               uuid: fakeSensorDictionary["Sensor3"]!.id)
        
        scannerdata.addscanner(scannerName: fakeSensorDictionary["Sensor4"]!.scannerName,
                               localName: fakeSensorDictionary["Sensor4"]!.localName,
                               rssi: fakeSensorDictionary["Sensor4"]!.rssi,
                               uuid: fakeSensorDictionary["Sensor4"]!.id)
        
        
        
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
        
        //let date = Date()
        //print(date)
        //peripheral.peripheral.delegate = self
        //centralManager.connect(peripheral.peripheral, options:nil)
        //print("The peripheral is: \(peripheral)")
//
//        var first: Bool = true
//        var sensorValue: Int = 0
        // ---------------------------------------------------------------------------
        if peripheral.scannerName == "Sensor1" {
            //let characteristic1 = fakeData
            //let characteristic2 = fakeData2
            let values1 = fakeData
            let values2 = fakeData2
            
//            values1.forEach { (digit) in
//                scannerdata.addFrontData(id: peripheral.id, sensorData: (digit))
//                }
//
//            values2.forEach { digit in
//                scannerdata.addBackData(id: peripheral.id, sensorData: (digit))
//            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        print("Timer fired!")
                        // Front Foot Data
                    self.scannerdata.addFrontData(id: peripheral.id, sensorData:
                            (values1[self.fakeDataIndex]))
                    self.fakeDataIndex = (self.fakeDataIndex + 1) % values1.count
                        // Back Foot Data
                    self.scannerdata.addBackData(id: peripheral.id, sensorData:
                            (values2[self.fakeDataIndex1]))
                    self.fakeDataIndex1 = (self.fakeDataIndex1 + 1) % values2.count
            }
        }
        // ---------------------------------------------------------------------------
        if peripheral.scannerName == "Sensor2" {
            let values1 = fakeData
            let values2 = fakeData2
            //let characteristic2 = fakeData2
//            values1.forEach { (digit) in
//                scannerdata.addFrontData(id: peripheral.id, sensorData: (digit))
//                }
//
//            values2.forEach { digit in
//                scannerdata.addBackData(id: peripheral.id, sensorData: (digit))
//            }

            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        print("Timer fired!")
                        // Front Foot Data
                    self.scannerdata.addFrontData(id: peripheral.id, sensorData:
                            (values1[self.fakeDataIndex]))
                    self.fakeDataIndex = (self.fakeDataIndex + 1) % values1.count
                        // Back Foot Data
                    self.scannerdata.addBackData(id: peripheral.id, sensorData:
                            (values2[self.fakeDataIndex1]))
                    self.fakeDataIndex1 = (self.fakeDataIndex1 + 1) % values2.count

            }
            
        }
        // ---------------------------------------------------------------------------
        if peripheral.scannerName == "Sensor3" {
            let values1 = CaraLeftT
            let values2 = CaraLeftH
            //let characteristic2 = fakeData2
//            values1.forEach { (digit) in
//                scannerdata.addFrontData(id: peripheral.id, sensorData: (digit))
//                }
//
//            values2.forEach { digit in
//                scannerdata.addBackData(id: peripheral.id, sensorData: (digit))
//            }
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        print("Timer fired!")
                        // Front Foot Data
                    self.scannerdata.addFrontData(id: peripheral.id, sensorData:
                            (values1[self.fakeDataIndex]))
                    self.fakeDataIndex = (self.fakeDataIndex + 1) % values1.count
                        // Back Foot Data
                    self.scannerdata.addBackData(id: peripheral.id, sensorData:
                            (values2[self.fakeDataIndex1]))
                    self.fakeDataIndex1 = (self.fakeDataIndex1 + 1) % values2.count

            }
            
        }
        // ---------------------------------------------------------------------------
        if peripheral.scannerName == "Sensor4" {
            let values1 = CaraRightT
            let values2 = CaraRightH
            //let characteristic2 = fakeData2
//            values1.forEach { (digit) in
//                scannerdata.addFrontData(id: peripheral.id, sensorData: (digit))
//                }
//
//            values2.forEach { digit in
//                scannerdata.addBackData(id: peripheral.id, sensorData: (digit))
//            }

            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        print("Timer fired!")
                        // Front Foot Data
                    self.scannerdata.addFrontData(id: peripheral.id, sensorData:
                            (values1[self.fakeDataIndex]))
                    self.fakeDataIndex = (self.fakeDataIndex + 1) % values1.count
                        // Back Foot Data
                    self.scannerdata.addBackData(id: peripheral.id, sensorData:
                            (values2[self.fakeDataIndex1]))
                    self.fakeDataIndex1 = (self.fakeDataIndex1 + 1) % values2.count
            }
        }
    }
        
        
//
//            let values = characteristic2
//                values.forEach { digit in
//                    scannerdata.addBackData(id: peripheral.id, sensorData: Int(digit))
//                }
        
        
//        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
//            print("Timer fired!")
//            self.scannerdata.addFrontData(id: peripheral.id, sensorData:
//                    Int(fakeData[self.fakeDataIndex]))
//            self.fakeDataIndex = (self.fakeDataIndex + 1) % fakeData.count
//        }
//        self.timer1 = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer1 in
//            print("Timer1 fired!")
//            self.scannerdata.addBackData(id: peripheral.id, sensorData:
//                    Int(fakeData2[self.fakeDataIndex1]))
//            self.fakeDataIndex1 = (self.fakeDataIndex1 + 1) % fakeData2.count
//
//        }
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
        
    
    
    
    
    
    
    func disconnect(peripheral: BLESensor) {
        var dataStringToe: [Double] = []
        var dataStringHeel: [Double] = []
        print("disconnect...")
        self.timer.invalidate()
        

//        scannerdata.appendToGlobalFront(id: peripheral.id, dataArray: peripheral.front_foot_data)
//        scannerdata.appendToGlobalBack(id: peripheral.id, dataArray: peripheral.back_foot_data)
        
        //centralManager.cancelPeripheralConnection(peripheral.peripheral)
        
        // Append dataset to global array
        //let dataList = peripheral.front_foot_data
        
        
        // ------------------------------------------------------
        // This is where Toe and Heel data gets saved to sa string
        //dataStringToe = dataStringToe + "Toe Data: (\(peripheral.front_foot_data.count) points) \n"
        
        
        for dataPoint in 0..<peripheral.front_foot_data.count {
            //print("Index: \(dataPoint), Value: \(peripheral.front_foot_data[dataPoint])")
            dataStringToe.append(peripheral.front_foot_data[dataPoint])
        }
        //print("\n")
        
        //dataStringHeel = dataStringHeel + "Heel Data: (\(peripheral.back_foot_data.count) points) \n"
        for dataPoint in 0..<peripheral.back_foot_data.count {
            //print("Index: \(dataPoint), Value: \(peripheral.front_foot_data[dataPoint])")
            dataStringHeel.append(peripheral.back_foot_data[dataPoint])
        }
        //print("\(dataStringToe)")
        //print("\(dataStringHeel)")
        // Acquiring the date/time info for the file header
        let date = NSDate();
        
        let formatter = DateFormatter();
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss";
        formatter.timeZone = TimeZone(abbreviation: "EST");
        let utcTimeZoneStr = formatter.string(from: date as Date);
        let fileIDToe = "Toe-Data"+"  "+utcTimeZoneStr
        let fileIDHeel = "Heel-Data"+"  "+utcTimeZoneStr
        
        print("\n\n\(fileIDToe)")
        print("\(fileIDHeel)\n\n")
        
        
        //print("Toe Data: \n\(peripheral.front_foot_data.count)")
        //print("Heel Data: \n\(peripheral.back_foot_data.count)")
        scannerdata.appendToAllToe(id: peripheral.id, dataArray: peripheral.front_foot_data)
        scannerdata.appendToAllHeel(id: peripheral.id, dataArray: peripheral.back_foot_data)
        
        scannerdata.remHeelData(id: peripheral.id)
        scannerdata.remToeData(id: peripheral.id)
        
//        print("\n\n\(fileIDToe)")
//        print("\(fileIDHeel)")
        
        //print("Toe Data Count: \(peripheral.front_foot_data.count)")
        //print("Heel Data count: \(peripheral.back_foot_data.count)")
        
        
        
        //let fileURLToe = URL(fileURLWithPath: fileIDToe, relativeTo: getDocumentsDirectory()).appendingPathExtension("txt")
        //let fileURLHeel = URL(fileURLWithPath: fileIDHeel, relativeTo: getDocumentsDirectory()).appendingPathExtension("txt")
        
        
        
        
//        do {
//            try dataStringToe.write(to: fileURLToe, atomically: true, encoding: String.Encoding.utf8)
//            try dataStringHeel.write(to: fileURLHeel, atomically: true, encoding: String.Encoding.utf8)
//            print("saving data...")
//        } catch {
//            print("something went wrong writing the data")
//            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//        }
        
        
        
        
        //scannerdata.appendToGlobalFront(id: peripheral.id, dataArray: peripheral.front_foot_data)
        //scannerdata.appendToGlobalBack(id: peripheral.id, dataArray: peripheral.back_foot_data)
        //createCSVX(from: [dataString])
    
        
        
        
        writetoCSV(datastring1:dataStringToe,label1: "Toe_Data",
                   datastring2:dataStringHeel,label2: "Heel_Data",
                   peripheral: peripheral,timeID: utcTimeZoneStr)
    
    
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    // --------------------------------------------------------------------------------------------
    // MARK: - CSV FILE SAVING
    func writetoCSV(datastring1:[Double], label1:String, datastring2:[Double], label2:String,
                    peripheral:BLESensor,timeID:String) {
        
        var dataArrayToe:[Dictionary<String, AnyObject>] =  Array()
        var dataArrayHeel:[Dictionary<String, AnyObject>] =  Array()
        
        for i in 0..<datastring1.count {
                var dct = Dictionary<String, AnyObject>()
                    let timeInd = Double(i)*0.05
                    dct.updateValue(i as AnyObject, forKey: "dataIndex")
                    dct.updateValue("\(timeInd)" as AnyObject, forKey: "timeIndex")
                    dct.updateValue(datastring1[i] as AnyObject, forKey: "Value")
                    dataArrayToe.append(dct)
        }
        for i in 0..<datastring2.count {
                var dct = Dictionary<String, AnyObject>()
                    let timeInd = Double(i)*0.05
                    dct.updateValue(i as AnyObject, forKey: "dataIndex")
                    dct.updateValue("\(timeInd)" as AnyObject, forKey: "timeIndex")
                    dct.updateValue(datastring1[i] as AnyObject, forKey: "Value")
                    dataArrayHeel.append(dct)
        }
        createCSV(from: dataArrayToe, dataLabel: label1+"_"+timeID,periph: peripheral)
        createCSV(from: dataArrayHeel, dataLabel: label2+"_"+timeID,periph: peripheral)
    }
    
        func createCSV(from recArray:[Dictionary<String, AnyObject>],dataLabel:String,periph:BLESensor) {
            var csvString = "\("Index"),\("Time"),\(periph.localName)\n\n"
                for dct in recArray {
                    csvString = csvString.appending("\(String(describing: dct["dataIndex"]!)),\(String(describing: dct["timeIndex"]!)),\(String(describing: dct["Value"]!))\n")
                }
                let fileManager = FileManager.default
                do {
                    let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
                    let fileURL = path.appendingPathComponent("\(periph.localName)\n\(dataLabel).csv")
                    try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("error creating file")
                }

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
//            }              // talked about a 1 or 2 representing the datapoint associated with peripheral 1 or 2 when appending the data packets HERE
//        }
//    }
    
//    let pressure_char_uuid = CBUUID(string:"5A8AC39C-0CE1-4212-8B46-D589BA126CE2")
        //let pressure_char_uuid = CBUUID(string:"6CE2")
//    let period_char_uuid = CBUUID(string:"F8BC0798-E447-4625-959F-CE6970B70ED1")
//    let pressure_service_uuid = CBUUID(string:"573BC605-1C3C-4467-B4AA-44E0C6C6B410")

}
