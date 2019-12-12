//
//  BluetoothViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

/*
import UIKit
import CoreBluetooth

//Central : 本アプリ
//Peripheral : Light Blue
final class BluetoothViewController: UIViewController {

    //GATTサービス(Heart Rate) https://www.bluetooth.com/ja-jp/specifications/gatt/services
    let kServiveUUIDHeartRate = "0x180D"

    //Attribute Types (UUIDs)
    let kCharacteristcUUIDHeartRateMeasurement = "0x2A37"

    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var serviceUUID : CBUUID!
    var charcteristicUUID: CBUUID!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    /// セントラルマネージャー、UUIDの初期化
    private func setup() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        serviceUUID = CBUUID(string: kServiveUUIDHeartRate)
        charcteristicUUID = CBUUID(string: kCharacteristcUUIDHeartRateMeasurement)
    }
}

//MARK : - CBCentralManagerDelegate
extension ViewController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        switch central.state {

        //電源ONを待って、スキャンする
        case CBManagerState.poweredOn:
            let services: [CBUUID] = [serviceUUID]
            centralManager?.scanForPeripherals(withServices: services,
                                               options: nil)
        default:
            break
        }
    }

    /// ペリフェラルを発見すると呼ばれる
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {

        self.peripheral = peripheral
        centralManager?.stopScan()

        //接続開始
        central.connect(peripheral, options: nil)
    }

    /// 接続されると呼ばれる
    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral) {

        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
    }
}

//MARK : - CBPeripheralDelegate
extension ViewController: CBPeripheralDelegate {

    /// サービス発見時に呼ばれる
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?) {

        if error != nil {
            print(error.debugDescription)
            return
        }

        //キャリアクタリスティク探索開始
        peripheral.discoverCharacteristics([charcteristicUUID],
                                           for: (peripheral.services?.first)!)
    }

    /// キャリアクタリスティク発見時に呼ばれる
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {

        if error != nil {
            print(error.debugDescription)
            return
        }

        peripheral.setNotifyValue(true,
                                  for: (service.characteristics?.first)!)
    }

    /// データ更新時に呼ばれる
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {

        if error != nil {
            print(error.debugDescription)
            return
        }

        updateWithData(data: characteristic.value!)
    }

    private func updateWithData(data : Data) {
        print(#function)

        let reportData = data.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: data.count))
        }

        /// Format Bitが0 or 1
        if (reportData.first != nil) && 0x01 == 0 {
            print("BPM: \(reportData.last!)")
        } else {
            print("BPM : \(CFSwapInt16LittleToHost(UInt16(reportData.last!)))")
        }
    }
}
 final class BluetoothService: NSObject {
     /// 接続先の機器
     private var connectPeripheral: CBPeripheral? = nil
     /// 対象のキャラクタリスティック
     private var writeCharacteristic: CBCharacteristic? = nil

     override init() {
         self.centralManager = CBCentralManager()
         self.peripheralManager = CBPeripheralManager()
     }

     // MARK: - Public Methods

     /// Bluetooth接続のセットアップ
     func setupBluetoothService() {
         self.centralManager = CBCentralManager(delegate: self, queue: nil)
         self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
     }

     /// スキャン開始
     func startBluetoothScan() {
         print("スキャン開始")
         // タイマーを設定する
         self.scanTimer = Timer.scheduledTimer(timeInterval: TimeInterval(10),
                                               target: self,
                                               selector: #selector(self.timeOutScanning),
                                               userInfo: nil,
                                               repeats: false)
         // 機器を検出
         if self.centralManager.isScanning == false {
             self.centralManager.scanForPeripherals(withServices: nil, options: nil)
         }
     }

     /// スキャン停止
     func stopBluetoothScan() {
         self.centralManager.stopScan()
         // Timerを削除
         self.scanTimer?.invalidate()
         self.scanTimer = nil
     }

     /// 機器に接続
     func connectPeripheral() {
         guard let connectPeripheral = self.connectPeripheral else {
             // 失敗処理
             return
         }
         self.centralManager.connect(connectPeripheral, options: nil)
     }
 }
// MARK: CBCentralManagerDelegate

extension BluetoothService: CBCentralManagerDelegate {

    /// Bluetoothのステータスを取得する(CBCentralManagerの状態が変わる度に呼び出される)
    ///
    /// - Parameter central: CBCentralManager
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Bluetooth PoweredOff")
            break
        case .poweredOn:
            print("Bluetooth poweredOn")
            break
        case .resetting:
            print("Bluetooth resetting")
            break
        case .unauthorized:
            print("Bluetooth unauthorized")
            break
        case .unknown:
            print("Bluetooth unknown")
            break
        case .unsupported:
            print("Bluetooth unsupported")
            break
        }
    }

    /// スキャン結果取得
    ///
    /// - Parameters:
    ///   - central: CBCentralManager
    ///   - peripheral: CBPeripheral
    ///   - advertisementData: アドバタイズしたデータを含む辞書型
    ///   - RSSI: 周辺機器の現在の受信信号強度インジケータ（RSSI）（デシベル単位）
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // 対象機器のみ保持する
        if let peripheralName = peripheral.name,
            peripheralName.contains(Const.Bluetooth.kPeripheralName) {
            // 対象機器のみ保持する
            self.connectPeripheral = peripheral
            // 機器に接続
            print("機器に接続：\(String(describing: peripheral.name))")
            self.centralManager.connect(peripheral, options: nil)
        }
    }

    /// 接続成功時
    ///
    /// - Parameters:
    ///   - central: CBCentralManager
    ///   - peripheral: CBPeripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("接続成功")
        self.connectPeripheral = peripheral
        self.connectPeripheral?.delegate = self
        // 指定のサービスを探索
        if let peripheral = self.connectPeripheral {
            peripheral.discoverServices([CBUUID(string: Const.Bluetooth.Service.kUUID)])
        }
        // スキャン停止処理
        self.stopBluetoothScan()
    }

    /// 接続失敗時
    ///
    /// - Parameters:
    ///   - central: CBCentralManager
    ///   - peripheral: CBPeripheral
    ///   - error: Error
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("接続失敗：\(String(describing: error))")
    }

    /// 接続切断時
    ///
    /// - Parameters:
    ///   - central: CBCentralManager
    ///   - peripheral: CBPeripheral
    ///   - error: Error
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("接続切断：\(String(describing: error))")
    }

}
// MARK: CBPeripheralDelegate

extension WearBluetoothService: CBPeripheralDelegate {

    /// キャラクタリスティック探索時(機器接続直後に呼ばれる)
    ///
    /// - Parameters:
    ///   - peripheral: CBPeripheral
    ///   - error: Error
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            // スキャン停止処理
            self.stopScan()
            // 失敗処理
            return
        }

        if let peripheralServices = peripheral.services {
            for service in peripheralServices where service.uuid == CBUUID(string: Const.Bluetooth.Service.kUUID) {
                print("キャラクタリスティック探索")
                // キャラクタリスティック探索開始
                let characteristicUUIDArray: [CBUUID] = [CBUUID(string: Const.Bluetooth.Characteristic.kUUID01),
                                                         CBUUID(string: Const.Bluetooth.Characteristic.kUUID02)]
                peripheral.discoverCharacteristics(characteristicUUIDArray, for: service)
            }
        }
    }
}
// MARK: CBPeripheralManagerDelegate

extension WearBluetoothService: CBPeripheralManagerDelegate {

    /// 端末のBluetooth設定を取得(WearBluetoothServiceの使用開始時、端末のBluetooth設定変更時に呼ばれる)
    ///
    /// - Parameter peripheral: CBPeripheralManager
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            // サービスを登録
            let service = CBMutableService(type: CBUUID(string: Const.Bluetooth.Service.kUUID), primary: true)
            self.peripheralManager.add(service)
        }
    }

    /// キャラクタリスティック発見時(機器接続直後に呼ばれる)
    ///
    /// - Parameters:
    ///   - peripheral: CBPeripheral
    ///   - service: CBService
    ///   - error: Error
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            // スキャン停止処理
            self.stopScan()
            print("キャラクタリスティック発見時：\(String(describing: error))")
            // エラー処理
            return
        }
        guard let serviceCharacteristics = service.characteristics else {
            // スキャン停止処理
            self.stopScan()
            // エラー処理
            return
        }
        // キャラクタリスティック別の処理
        for characreristic in serviceCharacteristics {
            if characreristic.uuid == CBUUID(string: Const.Bluetooth.Characteristic.kUUID01) {
                // データ書き込み用のキャラクタリスティックを保持
                self.writeCharacteristic = characreristic
                print("Write 01")
            }
            if characreristic.uuid == CBUUID(string: Const.Bluetooth.Characteristic.kUUID02) {
                isNotDiscoverCharacteristic02 = false
                peripheral.setNotifyValue(true, for: characreristic)
                print("Notify 02")
            }
        }
    }

    /// キャラクタリスティックにデータ書き込み時(コマンド送信時に呼ばれる)
    ///
    /// - Parameters:
    ///   - peripheral: CBPeripheral
    ///   - characteristic: CBCharacteristic
    ///   - error: Error
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("キャラクタリスティックデータ書き込み時エラー：\(String(describing: error))")
            // 失敗処理
            return
        }
        // 読み込み開始
        peripheral.readValue(for: characteristic)
    }

    /// キャラクタリスティック値取得・変更時(コマンド送信後、受信時に呼ばれる)
    ///
    /// - Parameters:
    ///   - peripheral: CBPeripheral
    ///   - characteristic: CBCharacteristic
    ///   - error: Error
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("キャラクタリスティック値取得・変更時エラー：\(String(describing: error))")
            // 失敗処理
            return
        }
        guard let data = characteristic.value else {
            // 失敗処理
            return
        }
        // データが渡ってくる
        print(data)
    }
}
*/
