//
//  ReterViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/13.
//

import UIKit

class ReterViewController: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
         super.viewDidLoad()
      completeButton.layer.cornerRadius = 20
     }
    override func viewDidAppear(_ animated: Bool) {
        
        //カスタマイズViewを生成
        // self.view.addSubview(UITextViewReter(frame: self.view.frame))
    }
    
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
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
