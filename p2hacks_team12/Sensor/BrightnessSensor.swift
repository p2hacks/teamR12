//
//  BrightnessSensor.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/13.
//

//
//  BrightnessViewController.swift
//  Bright
//
//  Created by 上野隆斗 on 2019/12/13.
//  Copyright © 2019 anonykous. All rights reserved.
//

import UIKit

class BrightnessViewController: UIViewController {

    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var brightnessStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()

               // Setup UIStepper
               let screen = UIScreen.main
               self.brightnessStepper.value = Double(screen.brightness)

               self.updateBrightnessLabel()

               // Observe screen brightness
               NotificationCenter.default.addObserver(self,
                                                                selector: #selector(screenBrightnessDidChange(_:)),
                                                                name: UIScreen.brightnessDidChangeNotification,
                                                                object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        NotificationCenter.default.removeObserver(self,
                                                  name: UIScreen.brightnessDidChangeNotification,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal methods
    func updateBrightnessLabel() {
        let screen = UIScreen.main
        self.brightnessLabel.text = "".appendingFormat("%.2f", screen.brightness)
    }

    @objc func screenBrightnessDidChange(_ notification: Notification) {
        if let screen = notification.object {
            self.brightnessLabel.text = "".appendingFormat("%.2f", (screen as AnyObject).brightness)
        }
    }

    // MARK: - Action methods
    @IBAction func stepperDidTap(_ stepper: UIStepper) {
        UIScreen.main.brightness = CGFloat(stepper.value)
        self.updateBrightnessLabel()
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
