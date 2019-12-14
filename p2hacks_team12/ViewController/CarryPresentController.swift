//
//  CarryPresentController.swift
//  p2hacks_team12
//
//  Created by 宮下翔伍 on 2019/12/13.
//

import UIKit

class CarryPresentController: UIViewController {
    
    @IBOutlet weak var ShowValue: UILabel! //音の大きさによってメッセージを送る
    @IBOutlet weak var level1View: UIImageView! //音の大きさに応じて画像を表示
    @IBOutlet weak var level2View: UIImageView!
    @IBOutlet weak var level3View: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var recorder: SoundAudioRecorder!
    var timer: Timer!
    var checksound:Float = 0.0 //音の大きさを格納
    var levelboader1to2:Float = 0.2 //1から2に警告が変わるライン
    var levelboader2to3:Float = 0.3 //2から3に警告が変わるライン
    var counttimer = 0.0 //一定時間をカウント
    var checktest = 1 //警告の切り替え信号
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = SoundAudioRecorder()
        recorder?.start()
        clearButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
    }
    
    //初期に一度だけ実行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        level1View.isHidden = false
        level2View.isHidden = true
        level3View.isHidden = true
        ShowValue.text = "安心！"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @objc func update(tm: Timer){
        checksound = recorder.level
        counttimer += 1/180 //現実時間に合うように調整
        if(checksound > levelboader1to2 || checktest == 2){ //音の大きさによって警告を変える
            checktest = 2
            if(counttimer < 2){ //一定時間警告
                if(checksound > levelboader2to3){
                    level2View.isHidden = false
                    level3View.isHidden = true
                    checktest = 3
                    ShowValue.text = "危険！"
                    counttimer = 0
                }
                level2View.isHidden = false
                level3View.isHidden = true
                ShowValue.text = "起きそう・・・"
            }else{
                level2View.isHidden = true
                level3View.isHidden = true
                checktest = 1
                ShowValue.text = "安心！"
                counttimer = 0
            }
        }else if(checksound > levelboader2to3 || checktest == 3){
             print("value=\(checksound)")
            checktest = 3
            if(counttimer < 4){
                counttimer += 1/180
                level2View.isHidden = false
                level3View.isHidden = false
                ShowValue.text = "危険！"
            }else{
                level2View.isHidden = true
                level3View.isHidden = true
                checktest = 1
                ShowValue.text = "安心！"
                counttimer = 0
            }
        }else { counttimer = 0}
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
