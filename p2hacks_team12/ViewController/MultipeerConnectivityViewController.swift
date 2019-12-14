//
//  MultipeerConnectivityViewController.swift
//  p2hacks_team12
//
//  Created by 上野隆斗 on 2019/12/12.
//

import UIKit
import BeerKit

class MultipeerConnectivityViewController: UIViewController,UITableViewDataSource{
    
    
    @IBOutlet weak var accelerationLabel: UILabel!
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    //tableviewの列数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
       
    //tableviewの要素
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = messages[indexPath.row].name
        cell.detailTextLabel?.text = messages[indexPath.row].message
        return cell
    }
    
    
//相手の名前を格納する変数
    @IBOutlet weak var deviceNameLabel: UILabel!
    //MessageEntityの2つの要素を格納するmesseges
    var messages: [MessageEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
                self.tableView.reloadData()
            }
        }
    }
    //ボタンタッチしたらデータを送る。これが送っている根元であろう。
    @IBAction func sayHiButtonTapped(_ sender: Any) {
        let message = MessageEntity(name: UIDevice.current.name, message: "Hi")
            let data: Data = try! JSONEncoder().encode(message)
            BeerKit.sendEvent("message", data: data)
        }
    }

