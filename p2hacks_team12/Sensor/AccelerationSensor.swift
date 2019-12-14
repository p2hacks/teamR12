//
//  AccelerationSensor.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/13.
//

import Foundation
import UIKit
import CoreMotion
 
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    
    // MotionManager
    let motionManager = CMMotionManager()
 
    // 3 axes
    @IBOutlet var accelerometerX: UILabel!
    @IBOutlet var accelerometerY: UILabel!
    @IBOutlet var accelerometerZ: UILabel!
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if motionManager.isAccelerometerAvailable {
            // intervalの設定 [sec]
            motionManager.accelerometerUpdateInterval = 0.2
 
            // センサー値の取得開始
            motionManager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.outputAccelData(acceleration: accelData!.acceleration)
            })
 
        }
    }
 //ラベルに移す
    func outputAccelData(acceleration: CMAcceleration){
        // 加速度センサー [G]
        accelerometerX.text = String(format: "%06f", acceleration.x)
        accelerometerY.text = String(format: "%06f", acceleration.y)
        accelerometerZ.text = String(format: "%06f", acceleration.z)
    }
 
    // センサー取得を止める場合
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
 
}
