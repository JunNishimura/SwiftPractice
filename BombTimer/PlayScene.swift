//
//  PlayScene.swift
//  BombTimer
//
//  Created by 西村純 on 2018/04/22.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class PlayScene: UIViewController {

    var timer : Timer!
    var startTime = Date()
    
    var okOrout : String = "ok"

    @IBOutlet weak var targetNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // set the color of magenta as the background of the button
        self.colchangeButton.backgroundColor = UIColor.magenta
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
        startTime = Date()
    }

    @objc func timerCount() {
        let currentTime = Date().timeIntervalSince(startTime)
        let num = Int(currentTime)
        let snum: String
        if num < 10 {
            snum = String(format: "%01d", num)
        } else {
            snum = String(format: "%02d", num)
        }
        targetNum.text = snum
        
        // 3の倍数もしくは３を含む数
        if num % 3 == 0 {
//            print("3の倍数です")
            checkcolofbutton(button: colchangeButton)
        } else if snum.index(of: "3") != nil {
//            print("3が含まれています")
            checkcolofbutton(button: colchangeButton)
        }
        print(okOrout)

        // change the background color of the button to default if it's changed
        if colchangeButton.backgroundColor == UIColor.red {
            colchangeButton.backgroundColor = UIColor.magenta
        }
    }
    
    func checkcolofbutton (button : UIButton) {
        if button.backgroundColor == UIColor.red {
            print("ok")
        } else {
            print("out")
        }
    }
    
    // variable to change the colof of button
    @IBOutlet weak var colchangeButton: UIButton!
    @IBAction func tappedButton(_ sender: UIButton) {
        if colchangeButton.backgroundColor == UIColor.magenta {
            // change the background to red
            colchangeButton.backgroundColor = UIColor.red
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
