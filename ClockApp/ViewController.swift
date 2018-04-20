//
//  ViewController.swift
//  ClockApp
//
//  Created by 西村純 on 2018/04/19.
//  Copyright © 2018年 NJ0303. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageNameArray = ["sleeping.png",
                          "breakfast.jpg",
                          "lunch.png",
                          "dinner.png",
                          "nightfood.png"]
    
    var timer : Timer?
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelAMPM: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func dispImg(dispImageNum : Int) {
        let name = imageNameArray[dispImageNum]
        
        let image = UIImage(named: name)
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initial update
        updateClock()
        // update constantly and call updateClock()
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.updateClock), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateClock() {
        // get the date description
        let date = Date()
        let calender = Calendar.current
        let requestedComponents : NSCalendar.Unit = [NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        let components = (calender as NSCalendar).components(requestedComponents, from: date)
        var hour = components.hour
        let minutes = components.minute
        
        // change the image depending on the time you open this app
        if hour! >= 0 && hour! < 6 {
            dispImg(dispImageNum: 0)
        } else if hour! >= 6 && hour! < 12 {
            dispImg(dispImageNum: 1)
        } else if hour! >= 12 && hour! < 19 {
            dispImg(dispImageNum: 2)
        } else if hour! >= 19 && hour! < 23 {
            dispImg(dispImageNum: 3)
        } else {
            dispImg(dispImageNum: 4)
        }
        
        // update the label (time)
        if hour! > 12 {
            hour = hour! - 12
            labelAMPM.text = "PM"
        } else {
            labelAMPM.text = "AM"
        }
        labelTime.text = padZero(hour!) + ":" + padZero(minutes!)
        // confirmation of calling update
        print("update")
    }
    
    func padZero(_ firstNum:Int) -> String {
        let secondNum = (firstNum < 10 ? "0" : "") + String(firstNum)
        return secondNum
    }
    
}

