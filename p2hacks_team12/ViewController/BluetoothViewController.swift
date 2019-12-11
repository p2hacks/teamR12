//
//  BluetoothViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit
import CoreBluetooth
class BluetoothViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var Textlog: UILabel!
    var centralManager: CBCentralManager? //セントラルマネージャー
       var myPeripheral: CBPeripheral? //ペリフェラルマネージャー
       let serviceUUID: [CBUUID] = [CBUUID(string: "0011")] //サービスID
       let characteristicsUUID: [CBUUID] = [CBUUID(string: "1234")] //キャラクタリスティックID
       let descriptorUUID: [CBUUID] = [CBUUID(string: "0000")]
    
       override func viewDidLoad() {
           super.viewDidLoad()
           // centralManager の初期化
           centralManager = CBCentralManager(delegate: self, queue: nil)
       }
        
       func centralManagerDidUpdateState(_ central: CBCentralManager) {
           switch (central.state) {
           case .unknown:
               print(".unknown")
               Textlog.text = "unknown"
               break
           case .resetting:
               print(".resetting")
             Textlog.text = "resetting"
            break
           case .unsupported:
               print(".unsupported")
                Textlog.text = "unsupported"
               break
           case .unauthorized:
               print(".unauthorized")
                Textlog.text = "unauthorized"
               break
           case .poweredOff:
               print(".poweredOff")
                Textlog.text = "poweredOff"
               break
           case .poweredOn:
               // Service UUID を指定してデバイスをスキャン
             Textlog.text = "powerdOn"
               centralManager!.scanForPeripherals(withServices: serviceUUID, options: nil)
               break
           @unknown default:
             Textlog.text = "unknownError"
        }
       }
    
    // デバイスを検出したら呼ばれる
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        myPeripheral = peripheral
        print("device name: \(myPeripheral!.name!)")
        centralManager!.connect(myPeripheral!, options: nil)
    }
    
    // デバイスへの接続が成功すると呼ばれる
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        myPeripheral!.delegate = self
        //指定されたサービスを探す
        myPeripheral!.discoverServices(serviceUUID)
    }
     
    // デバイスへの接続が失敗すると呼ばれる
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connect failed...")
    }
    
    // サービスの検索が成功したら呼ばれる
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Discover Services")
        let service: CBService = myPeripheral!.services![0]
        myPeripheral!.discoverCharacteristics(characteristicsUUID, for: service)
    }
    
    // Characteristics を発見したら呼ばれる
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Find Characteristics")
     var message = "Bluetooth is Success"
        let data = message.data(using: String.Encoding.utf8, allowLossyConversion: true)
    
        //ペリフェラルの保持しているキャラクタリスティクスから特定のものを探す
        for i in service.characteristics!{
            if i.uuid.uuidString == "書き込みを行いたいUUID"{
                //Notification を受け取るというハンドラ
                peripheral.setNotifyValue(true, for: i)
                //書き込み
                peripheral.writeValue(data! , for: i, type: .withResponse)
            }
        }
    }
    // Notificationを受け取ったら呼ばれる
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        // valueの中にData型で値が入っている
        print(characteristic.value)
    }
    
    
}
