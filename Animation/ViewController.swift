//
//  ViewController.swift
//  Animation
//
//  Created by 西村純 on 2018/04/25.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(createGeometry), userInfo: nil, repeats: true)
    }
    
    @objc func createGeometry() {
        // clean the view each time we call this function
        removeAllSubViews(ParentView: self.view)
        
        // create 30 rectangles whose parameters are all randomized
        for _ in 0..<30 {
            let width = Int(arc4random_uniform(UInt32(130))) + 20
            let height = width
            let x = Int(arc4random_uniform(UInt32(self.view.bounds.width)-UInt32(width)))
            let y = Int(arc4random_uniform(UInt32(self.view.bounds.height)-UInt32(height)))
            
            let testView = UIView.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
            
            testView.backgroundColor = generateRandomColor()
            
            // testView.alphaと個々がもつ自身の色のalphaはまた別の話
            UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                testView.alpha = 1.0
            }, completion: nil)
            self.view.addSubview(testView)
        }
    }
    
    // function to generate randomized color and alpha
    func generateRandomColor() -> UIColor {
        let randomR : CGFloat = CGFloat(drand48())
        let randomG : CGFloat = CGFloat(drand48())
        let randomB : CGFloat = CGFloat(drand48())
        let randomA : CGFloat = CGFloat(drand48()) + 0.1
        return UIColor(red: randomR, green: randomG, blue: randomB, alpha: randomA)
    }
    
    // function to clean the view
    func removeAllSubViews(ParentView: UIView) {
        let subviews = ParentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

