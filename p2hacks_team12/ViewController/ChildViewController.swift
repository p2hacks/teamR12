//
//  ChildViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit

class ChildViewController: UIViewController {
    
    @IBOutlet weak var snowView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var Xmas: UILabel!
    @IBOutlet weak var ParentLetter: UIButton!
    let date = DateManager()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Xmas.textColor = UIColor.white
        Xmas.text = "クリスマスまであと"
        letter.textColor = UIColor.white
        letter.text = "サンタさんへ手紙を書こう!"
        ParentLetter.setTitle("サンタさんへメッセージを書く！", for: .normal) // ボタンのタイトル
        ParentLetter.setTitleColor(UIColor.white, for: .normal) // タイトルの色
        countLabel.textColor = UIColor.white
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let a = UITextViewReter(frame: self.view.frame)
        a.frame =  CGRect(x: 0.0, y: 150.0, width: 350.0, height: 500.0)
        //カスタマイズViewを生成
                self.view.addSubview(a)
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
        timer = nil
    }
    
    @objc func update(tm: Timer) {

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
