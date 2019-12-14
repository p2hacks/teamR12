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
    @IBOutlet weak var ParentLetter: UIButton!
    let date = DateManager()
    let motionmanager = CMMotionManager()
    var timer: Timer!
    var datatimer: Timer!
    var soundrecoder: SoundAudioRecorder!
    var brightness: BrightnessSensor!
    var checksound: Float = 0.0
    var sounddata = 1
    var acceledata = 1
    var brightnessdata = 1
    var accelX: Double = 0.0
    var accelY: Double = 0.0
    var accelZ: Double = 0.0
    var brightnessValue: CGFloat = 0.0
    var counttime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 表示したい画像の名前(拡張子含む)を引数とする。
               self.view.addBackground(name: "backgroundLetter1.png")
        soundrecoder = SoundAudioRecorder()
        brightness = BrightnessSensor()
    
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
        brightness.updateBrightnessdata()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(brightness.screenBrightnessDidChange(_:)),
                                                    name: UIScreen.brightnessDidChangeNotification,
                                                    object: nil)
        soundrecoder?.start()
        // Do any additional setup after loading the view.
        ParentLetter.setTitle("サンタさんへメッセージを書く！", for: .normal) // ボタンのタイトル
        ParentLetter.setTitleColor(UIColor.red, for: .normal) // タイトルの色
        countLabel.textColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let a = UITextViewReter(frame: self.view.frame)
        a.frame =  CGRect(x: 0.0, y: 150.0, width: 350.0, height: 500.0)
        //カスタマイズViewを生成
                self.view.addSubview(a)
    }
    
    override func viewWillAppear(_ animated: Bool) { //一度だけ処理を実行

        super.viewWillAppear(true)
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        datatimer =
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.InputSoundandBrightnessData), userInfo: nil, repeats: true)
        NotificationCenter.default.removeObserver(self,
                                                        name: UIScreen.brightnessDidChangeNotification,
                                                        object: nil)
        datatimer.fire()
        timer.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func InputAccelerationdata(acceleration: CMAcceleration){ //子供端末で加速度の値を取得して格納
        accelX = acceleration.x
        accelY = acceleration.y
        if((accelX < 0.1 && accelX > -0.1)&&(accelY < 0.1 && accelY > -0.1)){ //加速度の大きさによってシグナルを送信
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
    @objc func InputSoundandBrightnessData(tm: Timer){ //子供端末で取得したセンサーの値を格納
        checksound = soundrecoder.level //音の大きさによってシグナルを送信
        if(checksound > 0.10) {
            sounddata = 3
        }else if(checksound > 0.03) {
            sounddata = 2
        }else{
            sounddata = 1
        }
         brightness.updateBrightnessdata() //画面の明るさに応じてシグナルを送信
        let lightvalue = brightness.brightnessValue
        if(lightvalue > 0.7) {
            brightnessdata = 1
        }else if(lightvalue > 0.3 && lightvalue <= 0.7) {
            brightnessdata = 2
        }else{
            brightnessdata = 3
        }
          print(brightnessdata)
    }
    
    @objc func update(tm: Timer) { //現在の日付を取得
        let count: Int = date.getXmaxTimeInterval()
        let count2: TimeInterval = TimeInterval(count)
        let formatter = DateComponentsFormatter()
        // 表示フォーマットを変更．.positionalや.fullで表示が変わる
        formatter.unitsStyle = .brief
        // 使用する単位　.minuteのみにすると232,071minのように出力．
        formatter.allowedUnits = [.day]
        print(count)
        // 作成したformatterでtimeintervalをstringに変換
        print(formatter.string(from: count2)!) // →5mths 10days 3hr 44min 28sec
        //時間をラベルに表示
        countLabel.text = formatter.string(from: count2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
