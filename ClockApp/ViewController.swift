//
//  ViewController.swift
//  ClockApp
//
//  Created by 西村純 on 2018/04/19.
//  Copyright © 2018年 NJ0303. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var timer : Timer?
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelAMPM: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初めに更新しておく
        updateClock()
        // ここでコンスタントに更新して、updateClockを呼びだす
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.updateClock), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateClock() {
        let date = Date()
        let calender = Calendar.current
        let requestedComponents : NSCalendar.Unit = [NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        let components = (calender as NSCalendar).components(requestedComponents, from: date)
        var hour = components.hour
        let minutes = components.minute
        if hour! > 12 {
            hour = hour! - 12
            labelAMPM.text = "PM"
        } else {
            labelAMPM.text = "AM"
        }
        labelTime.text = padZero(hour!) + ":" + padZero(minutes!)
        // 呼び出しの確認
        print("update")
    }
    
    func padZero(_ firstNum:Int) -> String {
        let secondNum = (firstNum < 10 ? "0" : "") + String(firstNum)
        return secondNum
    }
    
}

