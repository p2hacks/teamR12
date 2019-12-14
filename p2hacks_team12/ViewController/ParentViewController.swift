//
//  ParentViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit

class ParentViewController: UIViewController {
    
    private let textRate:UITextView = UITextView()
    private let labelRate:UILabel = UILabel()
    private let buttonDraw:UIButton = UIButton()
    private let chartView:ChartView = ChartView()
    private let textRateOne:UITextView = UITextView()
    private let labelRateOne:UILabel = UILabel()
    private let buttonDrawOne:UIButton = UIButton()
    private let chartViewOne:ChartView = ChartView()
    private let textRateTwo:UITextView = UITextView()
    private let labelRateTwo:UILabel = UILabel()
    private let buttonDrawTwo:UIButton = UIButton()
    private let chartViewTwo:ChartView = ChartView()
    private let textRateThree:UITextView = UITextView()
    private let labelRateThree:UILabel = UILabel()
    private let buttonDrawThree:UIButton = UIButton()
    private let chartViewThree:ChartView = ChartView()
    
    @IBOutlet weak var dangerRate: UILabel!
    @IBOutlet weak var degreeOfRisk: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textRate.layer.cornerRadius = 10
        textRate.layer.borderColor = UIColor.lightGray.cgColor
        textRate.layer.borderWidth = 0.5
        textRate.keyboardType = .numberPad
        textRate.text = "75" //とりあえずデフォル値は75%
        textRate.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textRate)
        
        labelRate.text = "%"
        self.view.addSubview(labelRate)
        buttonDraw.setTitle("グラフ表示", for: .normal)
        buttonDraw.setTitleColor(UIColor.blue, for: .normal)
        buttonDraw.addTarget(self, action: #selector(self.touchUpButtonDraw), for: .touchUpInside)
        self.view.addSubview(buttonDraw)
        
        self.view.addSubview(chartView)
        
        changeScreen()
        
        textRateOne.layer.cornerRadius = 10
        textRateOne.layer.borderColor = UIColor.lightGray.cgColor
        textRateOne.layer.borderWidth = 0.5
        textRateOne.keyboardType = .numberPad
        textRateOne.text = "30" //とりあえずデフォル値は30%
        textRateOne.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textRateOne)
        
        labelRateOne.text = "%"
        self.view.addSubview(labelRateOne)
        buttonDrawOne.setTitle("グラフ表示", for: .normal)
        buttonDrawOne.setTitleColor(UIColor.blue, for: .normal)
        buttonDrawOne.addTarget(self, action: #selector(self.touchUpButtonDrawOne), for: .touchUpInside)
        self.view.addSubview(buttonDrawOne)
        
        self.view.addSubview(chartViewOne)
        
        changeScreenOne()
        
        textRateTwo.layer.cornerRadius = 10
        textRateTwo.layer.borderColor = UIColor.lightGray.cgColor
        textRateTwo.layer.borderWidth = 0.5
        textRateTwo.keyboardType = .numberPad
        textRateTwo.text = "50" //とりあえずデフォル値は50%
        textRateTwo.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textRateTwo)
        
        labelRateTwo.text = "%"
        self.view.addSubview(labelRateTwo)
        buttonDrawTwo.setTitle("グラフ表示", for: .normal)
        buttonDrawTwo.setTitleColor(UIColor.blue, for: .normal)
        buttonDrawTwo.addTarget(self, action: #selector(self.touchUpButtonDrawTwo), for: .touchUpInside)
        self.view.addSubview(buttonDrawTwo)
        
        self.view.addSubview(chartViewTwo)
        
        changeScreenTwo()
        
        textRateThree.layer.cornerRadius = 10
        textRateThree.layer.borderColor = UIColor.lightGray.cgColor
        textRateThree.layer.borderWidth = 0.5
        textRateThree.keyboardType = .numberPad
        textRateThree.text = "10" //とりあえずデフォル値は10%
        textRateThree.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textRateThree)
        
        labelRateThree.text = "%"
        self.view.addSubview(labelRateThree)
        buttonDrawThree.setTitle("グラフ表示", for: .normal)
        buttonDrawThree.setTitleColor(UIColor.blue, for: .normal)
        buttonDrawThree.addTarget(self, action: #selector(self.touchUpButtonDrawThree), for: .touchUpInside)
        self.view.addSubview(buttonDrawThree)
        
        self.view.addSubview(chartViewThree)
        
        changeScreenThree()
        
    }
    
    /**
     端末の向きの変更のイベント
     */
    /*override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     super.viewWillTransition(to: size, with: coordinator)
     coordinator.animate(
     alongsideTransition: nil,
     completion: {(UIViewControllerTransitionCoordinatorContext) in
     self.changeScreen()
     }
     )
     }*/
    
    override func viewWillAppear(_ animated: Bool) {
        drawChart()
        drawChartOne()
        drawChartTwo()
        drawChartThree()
        
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
        chartView.frame = CGRect(x: widthValue/2-drawWidth/2, y: 160, width: drawWidth, height: drawWidth)
        
        
    }
    
    private func changeScreenOne(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateOne.frame = CGRect(x: widthValue/2-170, y: 50, width: 100, height: 40)
        labelRateOne.frame = CGRect(x: widthValue/2-70, y: 50, width: 40, height: 40)
        buttonDrawOne.frame = CGRect(x: widthValue/2-30, y: 50, width: 200, height: 40)
        
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewOne.frame = CGRect(x: 20, y: 570, width: 80, height: 80)
        
        
    }
    
    private func changeScreenTwo(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateTwo.frame = CGRect(x: widthValue/2-170, y: 90, width: 100, height: 40)
        labelRateTwo.frame = CGRect(x: widthValue/2-70, y: 90, width: 40, height: 40)
        buttonDrawTwo.frame = CGRect(x: widthValue/2-30, y: 90, width: 200, height: 40)
        
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewTwo.frame = CGRect(x: 150, y: 570, width: 80, height: 80)
        
        
    }
    
    private func changeScreenThree(){
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        textRateThree.frame = CGRect(x: widthValue/2-170, y: 90, width: 100, height: 40)
        labelRateThree.frame = CGRect(x: widthValue/2-70, y: 90, width: 40, height: 40)
        buttonDrawThree.frame = CGRect(x: widthValue/2-30, y: 90, width: 200, height: 40)
        
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue){
            drawWidth = heightValue * 0.8
        }
        chartViewThree.frame = CGRect(x: 280, y: 570, width: 80, height: 80)
        
        
    }
    
    
    @objc func touchUpButtonDraw(){
        drawChart()
        
    }
    
    @objc func touchUpButtonDrawOne(){
        drawChartOne()
        
    }
    
    @objc func touchUpButtonDrawTwo(){
        drawChartTwo()
        
    }
    
    @objc func touchUpButtonDrawThree(){
        drawChartThree()
        
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
