//
//  ViewController.swift
//  TileAnimation
//
//  Created by 西村純 on 2018/04/26.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numBoxX: Int = 5
    var timer: Timer!
    var testView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.f
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(createTile), userInfo: nil, repeats: true)
//        createTile()
    }
    
    @objc func createTile() {
        // clean the screen each time this function is called
        removeAllSubviews(ParentView: self.view)
        
        let boxWidth = self.view.bounds.width / CGFloat(numBoxX)
        let boxHeight = boxWidth
        let numBoxY = Int(self.view.bounds.height / boxHeight) + 1
        
        for i in 0..<numBoxY{
            for j in 0..<numBoxX {
                let x = boxWidth * CGFloat(j)
                let y = boxHeight * CGFloat(i)
                testView = UIView.init(frame: CGRect.init(x: x, y: y, width: boxWidth, height: boxHeight))
                testView.backgroundColor = generateRandomColor()
                self.view.addSubview(testView)
                
                addEffects()
            }
        }
    }
    
    func generateRandomColor() -> UIColor {
        let randomR : CGFloat = CGFloat(drand48())
        let randomG : CGFloat = CGFloat(drand48())
        let randomB : CGFloat = CGFloat(drand48())
        let randomA : CGFloat = CGFloat(drand48()) + 0.1
        return UIColor(red: randomR, green: randomG, blue: randomB, alpha: randomA)
    }

    // this is the function to make the shape of the object round
    func addEffects() {
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        
        let animation1 = CABasicAnimation(keyPath: "cornerRadius")
        animation1.fromValue = 0.0
        animation1.toValue = Int(arc4random_uniform(30))
        
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.fromValue = Int(arc4random_uniform(5))
        animation2.toValue = drand48() > 0.5 ? 1.0 : 0.0
        
        let animation3 = CABasicAnimation(keyPath: "transform.rotation")
        animation3.fromValue = 0.0
        animation3.toValue = M_PI * Double(arc4random_uniform(5))
        animation3.speed = Float(arc4random_uniform(5))
        
        animationGroup.animations = [animation1, animation2, animation3]
        testView.layer.add(animationGroup, forKey: nil)
    }
    
    func removeAllSubviews(ParentView: UIView) {
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

