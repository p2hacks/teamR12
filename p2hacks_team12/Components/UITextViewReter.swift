//
//  UITextViewReter.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/13.
//

import UIKit

class UITextViewReter: UIView, UITextFieldDelegate {
    let tv = UITextView(frame: CGRect(x: 40, y: 72, width: 300, height: 430))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tv)
        
        //tv.center = self.center
        
        // 文字
        tv.text = "ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ"
        
        // 文字色
        tv.textColor = UIColor.black
        tv.backgroundColor = UIColor.clear
        // フォント
        tv.font = UIFont.systemFont(ofSize: 19.0)
        
        // 中心揃え
        tv.textAlignment = NSTextAlignment.center
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0.2
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        tv.attributedText = NSAttributedString(string: tv.text,
                                               attributes: attributes)
        // フォント
        tv.font = UIFont(name: "Arial",size: 19.0)
        // 文字を編集不可能にする
        //tv.isEditable = false
        // ツールバー生成
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        // スタイルを設定
        toolBar.barStyle = UIBarStyle.default
        // 画面幅に合わせてサイズを変更
        toolBar.sizeToFit()
        // 閉じるボタンを右に配置するためのスペース?
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(UITextViewReter.commitButtonTapped))
        // スペース、閉じるボタンを右側に配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        tv.inputAccessoryView = toolBar
        
    }
    //ボタンを押したら閉じる
    @objc func commitButtonTapped() {
        self.tv.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
