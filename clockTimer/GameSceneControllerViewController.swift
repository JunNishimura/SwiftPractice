//
//  GameSceneControllerViewController.swift
//  clockTimer
//
//  Created by 西村純 on 2018/04/24.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class GameSceneControllerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var restartLabel: UIButton!
    
    var timer: Timer!
    var count: Int = 0
    var randomNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        buttonLabel.backgroundColor = UIColor.magenta
        
        // set the target time by random number from 10-30
        randomNum = Int(arc4random_uniform(21)) + 10
        targetTimeLabel.text = "target : \(randomNum)"
        
        // set the opacity of resultLabel and restartLabel as transparent
        resultLabel.textColor = UIColor.clear
        restartLabel.setTitleColor(UIColor.clear, for: .normal)
    }

    @IBAction func ButtonEvent(_ sender: UIButton) {
        // change the color and title of the button
        if buttonLabel.backgroundColor == UIColor.magenta {
            buttonLabel.backgroundColor = UIColor.red
            buttonLabel.setTitle("Stop", for: .normal)
        } else {
            buttonLabel.backgroundColor = UIColor.magenta
            buttonLabel.setTitle("Done", for: .normal)
            
            // show the final comment
            resultLabel.textColor = UIColor.black
            if randomNum == count {
                resultLabel.text = "Great!"
            } else {
                resultLabel.text = "Fool!"
            }
            
            // show the restart button
            restartLabel.setTitleColor(UIColor.black, for: .normal)
        }
        
        // start timer
        // if it's already started, then stop it
        if timer != nil {
            timer.invalidate()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCount() {
        count += 1
        count = count % 50
        if count < 10 {
            timerLabel.text = String(format: "%01d", count)
        } else if count < 31 {
            timerLabel.text = String(format: "%02d", count)
        } else {
            count = 30
            resultLabel.textColor = UIColor.black
            resultLabel.text = "Time Over"
            // show the restart button
            restartLabel.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
