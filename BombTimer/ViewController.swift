//
//  ViewController.swift
//  BombTimer
//
//  Created by 西村純 on 2018/04/19.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // change the background color to gray
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    @IBAction func pressStart(_ sender: UIButton) {
        performSegue(withIdentifier: "toPlayScene", sender: nil)
    }
    
        
//    func timerCounter() {
//        let currentTime = Date().timeIntervalSince(startTime)
//        let minute = (Int)(fmod((currentTime/60), 60))
//        let second = (Int)(fmod(currentTime, 60))
//        let sminute = String(format: "%02d", minute)
//        let ssecond = String(format: "%02d", second)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

