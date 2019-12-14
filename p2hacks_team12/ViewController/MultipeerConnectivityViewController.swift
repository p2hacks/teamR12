//
//  MultipeerConnectivityViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/12.
//

import UIKit
import BeerKit

class MultipeerConnectivityViewController: UIViewController{
    
    
    @IBOutlet weak var accelerationLabel: UILabel!
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
   
    
    
//相手の名前を格納する変数
    @IBOutlet weak var deviceNameLabel: UILabel!
    //MessageEntityの2つの要素を格納するmesseges
    var messages: [MessageEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //相手のid表示
        BeerKit.onConnect { (myPeerId, peerId) in
            DispatchQueue.main.async {
                self.deviceNameLabel.text = peerId.displayName
            }
        }
            //わからん
        BeerKit.onEvent("message") { (peerId, data) in
            guard let data = data,
                let message = try? JSONDecoder().decode(MessageEntity.self, from: data) else {
                    return
             }
            self.messages.append(message)
            
            DispatchQueue.main.async {
               // self.accelerationLabel.text = "accelerationLabel"
            }
        }
    }
    //ボタンタッチしたらデータを送る。これが送っている根元であろう。
    }

