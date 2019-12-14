//
//  MainViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var DownAnimationView: UIView!
    @IBOutlet weak var TopAnimationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        snowAnimation()
        snow2Animation()
        // Do any additional setup after loading the view.
    }
    func snowAnimation() {
        self.TopAnimationView.frame = CGRect(x: 0, y: -1200, width: self.TopAnimationView.frame.width, height: self.TopAnimationView.frame.height)
        UIView.animate(withDuration: 48.0, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                   //1:下へ300px動く
                   self.TopAnimationView.frame = CGRect(x: self.TopAnimationView.frame.origin.x,
                                               y: self.TopAnimationView.frame.origin.y + 2400,
                                               width: self.TopAnimationView.frame.width,
                                               height: self.TopAnimationView.frame.height)
               }, completion: { finished in
                   self.snowAnimation()
               })
    }
    func snow2Animation() {
        
       
        self.DownAnimationView.frame = CGRect(x: 0, y: -600, width: self.DownAnimationView.frame.width, height: self.DownAnimationView.frame.height)
        UIView.animate(withDuration: 24.0, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            //1:下へ300px動く
            self.DownAnimationView.frame = CGRect(x: 0, y: self.DownAnimationView.frame.origin.y + 1200, width: self.DownAnimationView.frame.width, height: self.DownAnimationView.frame.height)
        }, completion: { finished in
            self.snow2Animation()
        })
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
