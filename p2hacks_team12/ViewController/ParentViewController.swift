//
//  ParentViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit
import BeerKit
class ParentViewController: UIViewController {
    
    private let textRate:UITextView = UITextView()
    private let labelRate:UILabel = UILabel()
    private let buttonDraw:UIButton = UIButton()
    private let chartView:ChartView = ChartView()
    
    var childview: ChildViewController!
    //MessageEntityの2つの要素を格納するmesseges
    var messages: [MessageEntity] = []
    
    private let textRateOne:UITextView = UITextView()
    private let labelRateOne:UILabel = UILabel()
    private let chartViewOne:ChartView = ChartView()
    private let textRateTwo:UITextView = UITextView()
    private let labelRateTwo:UILabel = UILabel()
    private let chartViewTwo:ChartView = ChartView()
    private let textRateThree:UITextView = UITextView()
    private let labelRateThree:UILabel = UILabel()
    private let chartViewThree:ChartView = ChartView()
    @IBOutlet weak var dangerRate: UILabel!
    @IBOutlet weak var degreeOfRisk: UILabel!
    @IBOutlet weak var brightnum: UILabel!
    @IBOutlet weak var accelnum: UILabel!
    @IBOutlet weak var soundnum: UILabel!
    var timer:Timer!
    var accelerationNumber = 3//仮に値入れてる
    var soundNumber = 1//仮に値入れてる
    var brightnessNumber = 1//仮に値入れてる
    var sum = 0
    var per:Int = 0
    var count = 0
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addBackground(name: "backgroundGray.png")
        childview = ChildViewController()
        
        switch sum {
        case 1:
            textRate.text = "11" //とりあえずデフォル値は30%
        case 2:
            textRate.text = "22" //とりあえずデフォル値は30%
        case 3:
            textRate.text = "33" //とりあえずデフォル値は30%
        case 4:
            textRate.text = "44" //とりあえずデフォル値は30%
        case 5:
            textRate.text = "55" //とりあえずデフォル値は30%
        case 6:
            textRate.text = "66" //とりあえずデフォル値は30%
        case 7:
            textRate.text = "77" //とりあえずデフォル値は30%
        case 8:
            textRate.text = "88" //とりあえずデフォル値は30%
        default:
            textRate.text = "100" //とりあえずデフォル値は30%
        }
        textRate.font = UIFont.systemFont(ofSize: 16)
        labelRate.text = "%"
        self.view.addSubview(chartView)
        changeScreen()
        
        textRateOne.layer.cornerRadius = 10
        textRateOne.layer.borderColor = UIColor.lightGray.cgColor
        textRateOne.layer.borderWidth = 0.5
        textRateOne.keyboardType = .numberPad
        switch accelerationNumber {
        case 1:
            textRateOne.text = "33" //とりあえずデフォル値は30%
        case 2:
            textRateOne.text = "66" //とりあえずデフォル値は30%
        default:
            textRateOne.text = "100" //とりあえずデフォル値は30%
        }
        textRateOne.font = UIFont.systemFont(ofSize: 16)
        labelRateOne.text = "%"
        
        
        self.view.addSubview(chartViewOne)
        
        changeScreenOne()
        
        textRateTwo.layer.cornerRadius = 10
        textRateTwo.layer.borderColor = UIColor.lightGray.cgColor
        textRateTwo.layer.borderWidth = 0.5
        textRateTwo.keyboardType = .numberPad
        switch soundNumber{
        case 1:
            textRateTwo.text = "33"
        case 2:
            textRateTwo.text = "66"
        default:
            textRateTwo.text = "100"
            
        }
        textRateTwo.font = UIFont.systemFont(ofSize: 16)
        
        labelRateTwo.text = "%"
        
        self.view.addSubview(chartViewTwo)
        
        changeScreenTwo()
        
        textRateThree.layer.cornerRadius = 10
        textRateThree.layer.borderColor = UIColor.lightGray.cgColor
        textRateThree.layer.borderWidth = 0.5
        textRateThree.keyboardType = .numberPad
        switch brightnessNumber {
        case 1:
            textRateThree.text = "33" //とりあえずデフォル値は30%
        case 2:
            textRateThree.text = "66" //とりあえずデフォル値は30%
        default:
            textRateThree.text = "100" //とりあえずデフォル値は30%
        }
        textRateThree.font = UIFont.systemFont(ofSize: 16)
        labelRateThree.text = "%"
        self.view.addSubview(chartViewThree)
        
        changeScreenThree()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.dataSession), userInfo: nil, repeats: true)
        timer.fire()
        drawChart()
        drawChartOne()
        drawChartTwo()
        drawChartThree()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @objc func dataSession(tm: Timer){
        count+=1
        BeerKit.onEvent("message") { (peerId, data) in
            guard let data = data,
                let message = try? JSONDecoder().decode(MessageEntity.self, from: data) else {
                    return
            }
            DispatchQueue.main.async {
                self.messages.append(message)
                let inputdata = self.messages[self.count-1]
                self.accelerationNumber = inputdata.acceleration
                self.accelnum.text = String(self.accelerationNumber)
                switch self.accelerationNumber {
                case 1:
                    self.textRateOne.text = "33" //とりあえずデフォル値は30%
                case 2:
                    self.textRateOne.text = "66" //とりあえずデフォル値は30%
                default:
                    self.textRateOne.text = "100" //とりあえずデフォル値は30%
                }
                self.labelRateOne.text = "%"
                self.view.addSubview(self.chartViewOne)
                self.changeScreenOne()
                self.drawChartOne()
                
                self.brightnessNumber = inputdata.brightness
                self.brightnum.text = String(self.brightnessNumber)
                switch self.brightnessNumber {
                case 1:
                    self.textRateTwo.text = "33" //とりあえずデフォル値は30%
                case 2:
                    self.textRateTwo.text = "66" //とりあえずデフォル値は30%
                default:
                    self.textRateTwo.text = "100" //とりあえずデフォル値は30%
                }
                self.labelRateTwo.text = "%"
                self.view.addSubview(self.chartViewTwo)
                self.changeScreenTwo()
                self.drawChartTwo()
                
                self.soundNumber = inputdata.sound
                self.soundnum.text = String(self.soundNumber)
                switch self.soundNumber {
                case 1:
                    self.textRateThree.text = "33" //とりあえずデフォル値は30%
                case 2:
                    self.textRateThree.text = "66" //とりあえずデフォル値は30%
                default:
                    self.textRateThree.text = "100" //とりあえずデフォル値は30%
                }
                self.labelRateThree.text = "%"
                self.view.addSubview(self.chartViewThree)
                self.changeScreenThree()
                self.drawChartThree()
                
                self.sum = self.soundNumber + self.brightnessNumber + self.accelerationNumber
                switch self.sum {
                case 1:
                    self.textRate.text = "11" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "小"
                case 2:
                    self.textRate.text = "22" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "小"
                    
                case 3:
                    self.textRate.text = "33" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "小"
                    
                case 4:
                    self.textRate.text = "44" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "中"
                    
                case 5:
                    self.textRate.text = "55" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "中"
                case 6:
                    self.textRate.text = "66" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "中"
                case 7:
                    self.textRate.text = "77" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "大"
                case 8:
                    self.textRate.text = "88" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "大"
                    
                default:
                    self.textRate.text = "100" //とりあえずデフォル値は30%
                    self.degreeOfRisk.text = "大"
                    
                }
                self.view.addSubview(self.degreeOfRisk)
                self.labelRate.text = "%"
                self.view.addSubview(self.chartView)
                self.changeScreen()
                self.drawChart()
            }
        }
        
        
    }
    
    
    private func changeScreen(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        
        textRate.frame = CGRect(x: widthValue/2-170, y: 10, width: 100, height: 40)
        labelRate.frame = CGRect(x: widthValue/2-70, y: 10, width: 40, height: 40)
        buttonDraw.frame = CGRect(x: widthValue/2-30, y: 10, width: 200, height: 40)
        
        
        
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartView.frame = CGRect(x: widthValue/2-drawWidth/2, y: 110, width: drawWidth, height: drawWidth)
        
        
    }
    
    private func changeScreenOne(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateOne.frame = CGRect(x: widthValue/2-170, y: 50, width: 100, height: 40)
        labelRateOne.frame = CGRect(x: widthValue/2-70, y: 50, width: 40, height: 40)
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewOne.frame = CGRect(x: 20, y: 520, width: 80, height: 80)
        
        
    }
    
    private func changeScreenTwo(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateTwo.frame = CGRect(x: widthValue/2-170, y: 90, width: 100, height: 40)
        labelRateTwo.frame = CGRect(x: widthValue/2-70, y: 90, width: 40, height: 40)
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewTwo.frame = CGRect(x: 150, y: 520, width: 80, height: 80)
        
        
    }
    
    private func changeScreenThree(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateThree.frame = CGRect(x: widthValue/2-170, y: 90, width: 100, height: 40)
        labelRateThree.frame = CGRect(x: widthValue/2-70, y: 90, width: 40, height: 40)
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewThree.frame = CGRect(x: 280, y: 520, width: 80, height: 80)
        
        
    }
    /**
     グラフを表示
     */
    private func drawChart(){
        let rate = Double(textRate.text!)
        chartView.drawChart(rate: rate!)
    }
    
    private func drawChartOne(){
        let rate = Double(textRateOne.text!)
        chartViewOne.drawChartMini(rate: rate!)
    }
    
    private func drawChartTwo(){
        let rate = Double(textRateTwo.text!)
        chartViewTwo.drawChartMini(rate: rate!)
    }
    
    private func drawChartThree(){
        let rate = Double(textRateThree.text!)
        chartViewThree.drawChartMini(rate: rate!)
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
