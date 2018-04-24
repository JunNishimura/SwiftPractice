//
//  GameScene.swift
//  BombTimer
//
//  Created by 西村純 on 2018/04/24.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class GameScene: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lastMessage1: UILabel!
    @IBOutlet weak var lastMessage2: UILabel!
    
    var timer: Timer!
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set the color of buttonLabel as magenta by default
        buttonLabel.backgroundColor = UIColor.magenta
        
        // make restart button transparent by default
        restartButton.setTitleColor(UIColor.clear, for: .normal)
        restartButton.backgroundColor = UIColor.clear
        
        // make lastmessage transparent by default
        lastMessage1.textColor = UIColor.clear
        lastMessage2.textColor = UIColor.clear
    }
    
    @objc func countTimer() {
        // ポイントはcount+1する前に判定すること
        if buttonLabel.backgroundColor == UIColor.red {
            
            let scount = String(count)
            if count % 3 == 0 {
                print("ok")
            } else if scount.index(of: "3") != nil {
                print("this num (\(count)) includes 3")
            } else {
                print("out")
                outEvent(message1: "GAME OVER!", message2: "\(count) is unrelated")
            }
        } else if buttonLabel.backgroundColor == UIColor.magenta {
            // こっちは、三の倍数にも関わらず、ボタンを押せなかった時にoutをだす
            let scount = String(count)
            if count % 3 == 0, count != 0{
                print("out")
                outEvent(message1: "GAME OVER!", message2: "YOU MISSED \(count)")
            } else if scount.index(of: "3") != nil {
                print("out")
                outEvent(message1: "GAME OVER!", message2: "YOU MISSED \(count)")
            }
        }
        
        count += 1
        countLabel.text = String(format: "%01d", count)
        
        // count > 50 で強制終了
        if count > 50 {
            timer.invalidate()
            outEvent(message1: "GAME CLEAR!", message2: "YOU GREAT!")
        }
        
        // change the bg color of buttonLabel if it's red
        if buttonLabel.backgroundColor == UIColor.red {
            buttonLabel.backgroundColor = UIColor.magenta
        }
    }
    
    @IBAction func buttonFunc(_ sender: UIButton) {
        if buttonLabel.backgroundColor == UIColor.magenta {
            buttonLabel.backgroundColor = UIColor.red
        }
    }
    
    // function called when user make a mistake
    func outEvent(message1: String, message2: String) {
        timer.invalidate()
        countLabel.textColor = UIColor.clear
        buttonLabel.setTitleColor(UIColor.clear, for: .normal)
        buttonLabel.backgroundColor = UIColor.clear
        
        // make lastmessage appear on the screen
        lastMessage1.textColor = UIColor.yellow
        lastMessage1.text = message1
        lastMessage2.textColor = UIColor.yellow
        lastMessage2.text = message2
        
        // make restartButton appear on the screen
        restartButton.setTitleColor(UIColor.white, for: .normal)
        restartButton.backgroundColor = UIColor.darkGray
    }
    
    @IBAction func startFunc(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
        // soon make startButton transparent
        startButton.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
