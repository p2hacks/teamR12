//
//  MainViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/10.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
  sequencialAnimation()
        // Do any additional setup after loading the view.
    }
    func sequencialAnimation() {

           // スケールを最初は０にする
           redView.transform = CGAffineTransform(scaleX: 0, y: 0)

           // UIView.animateを入れ子にしていく
        UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(rawValue: 0), animations: {
               // ① スケールが1.0になって出現
               self.redView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: { finished in

               // ①が終わったら、
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(rawValue: 0), animations: {
                   // ② 右へ100px動く
                   self.redView.frame = CGRect(x: self.redView.frame.origin.x + 100,
                                               y: self.redView.frame.origin.y,
                                               width: self.redView.frame.width,
                                               height: self.redView.frame.height)
               }, completion: { finished in

                   // ②が終わったら、
                UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(rawValue: 0), animations: {
                       // ③ 元の位置に戻る
                       self.redView.frame = CGRect(x: self.redView.frame.origin.x - 100,
                                                   y: self.redView.frame.origin.y,
                                                   width: self.redView.frame.width,
                                                   height: self.redView.frame.height)
                   }, completion: { finished in

                       // ③が終わったら
                    UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(rawValue: 0), animations: {
                           // ④ スケールが0になって消える
                           //（0を入れるとどういうわけかアニメーションしませんでした。そのため0.0001という小さい値をとりあえず入れています。他の方法がわからなかったので、ご存知でしたら教えてくださいm(_ _)m）
                           self.redView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                       }, completion: { finished in

                           // ④が終わったら、もう一度このメソッドを呼び出す
                           self.sequencialAnimation()
                       })
                   })
               })
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
