//
//  ViewController.swift
//  CalculationApp
//
//  Created by 西村純 on 2018/04/27.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    
    var timer: Timer!
    
    // function to come back to top page
    @IBAction func returnTop(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createNumer), userInfo: nil, repeats: true)
    }
    
    @objc func createNumer() {
        // clean the view
        removeAllSubViews(ParentView: self.view)
        
        // create 30 numbers
        for _ in 0..<30 {
            let label = UILabel()
            let randomNum = Int(arc4random_uniform(10))
            label.text = String(format: "%01d", randomNum)
            let width = 50
            let height = width
            let xpos = Int(arc4random_uniform(UInt32(self.view.bounds.width) - UInt32(width)))
            let ypos = Int(arc4random_uniform(UInt32(self.view.bounds.height) - UInt32(height)))
            label.frame = CGRect(x: xpos, y: ypos, width: width, height: height)
            label.textColor = UIColor.gray
            label.textAlignment = NSTextAlignment.center
            label.backgroundColor = UIColor.clear
            let randomSize = Int(arc4random_uniform(40)) + 30
            label.font = UIFont(name: "CourierNewPS-BoldMT", size: CGFloat(randomSize))
            
            self.view.addSubview(label)
            self.view.addSubview(startButtonLabel)
            self.view.addSubview(titleLabel)
        }
    }
    
    func removeAllSubViews(ParentView: UIView) {
        let subViews = ParentView.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

