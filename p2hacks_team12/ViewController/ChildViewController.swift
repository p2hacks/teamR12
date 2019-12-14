//
//  ChildViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit
import CoreMotion

class ChildViewController: UIViewController {
    
    @IBOutlet weak var snowView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var Xmas: UILabel!
    let date = DateManager()
    let motionmanager = CMMotionManager()
    var timer: Timer!
    var datatimer: Timer!
    var soundrecoder: SoundAudioRecorder!
    var acceleration: AccelerationSensor!
    var checksound: Float = 0.0
    var sounddata = 1
    var acceledata = 1
    var accelX: Double = 0.0
    var accelY: Double = 0.0
    var accelZ: Double = 0.0
    var counttime = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if motionmanager.isAccelerometerAvailable {
            // intervalの設定 [sec]
            motionmanager.accelerometerUpdateInterval = 1.0
            // センサー値の取得開始
            motionmanager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.InputAccelerationdata(acceleration: accelData!.acceleration)
            })
        }
        soundrecoder = SoundAudioRecorder()
        acceleration = AccelerationSensor()
        soundrecoder?.start()
        // Do any additional setup after loading the view.
        Xmas.text = "クリスマスまであと"
        letter.text = "サンタさんへ手紙を書こう!"
    }
    
    override func viewWillAppear(_ animated: Bool) { //一度だけ処理を実行
        super.viewWillAppear(true)
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        datatimer =
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.InputSoundData), userInfo: nil, repeats: true)
        datatimer.fire()
        timer.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func InputAccelerationdata(acceleration: CMAcceleration){
        accelX = acceleration.x
        accelY = acceleration.y
        if((accelX < 0.1 && accelX > -0.1)&&(accelY < 0.1 && accelY > -0.1)){
            counttime += 1
            print(counttime)
            if(counttime < 5){
                acceledata = 2
                print("加速度安心度はレベル2です")
            }else{
                print("加速度安心度はレベル3です")
                acceledata = 3
            }
        }else{
            counttime = 0
            print("加速度安心度はレベル1です")
            acceledata = 1
        }
    }
    @objc func InputSoundData(tm: Timer){ //子供端末で取得したセンサーの値を格納
        checksound = soundrecoder.level
        if(checksound > 0.10){
            sounddata = 3
        }else if(checksound > 0.03){
            sounddata = 2
        }else{
            sounddata = 1
        }
        // print(sounddata)
        
    }
    @objc func update(tm: Timer) { //現在の日付を取得
        let count: Int = date.getXmaxTimeInterval()
        let count2: TimeInterval = TimeInterval(count)
        let formatter = DateComponentsFormatter()
        // 表示フォーマットを変更．.positionalや.fullで表示が変わります．
        formatter.unitsStyle = .brief
        // 使用する単位　.minuteのみにすると232,071minのように出力されます．
        formatter.allowedUnits = [.day]
        // 作成したformatterでtimeintervalをstringに変換します．
        print(formatter.string(from: count2)!) // →5mths 10days 3hr 44min 28sec
        //時間をラベルに表示
        countLabel.text = formatter.string(from: count2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
