//
//  ResetPage.swift
//  CalculationApp
//
//  Created by 西村純 on 2018/04/28.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ResetPage: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentLabel.alpha = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addAnimation), userInfo: nil, repeats: false)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
            self.commentLabel.alpha = 1.0
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
