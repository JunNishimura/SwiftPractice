//
//  HardScene.swift
//  CalculationApp
//
//  Created by 西村純 on 2018/04/27.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class HardScene: UIViewController {

    @IBOutlet weak var calcLabel: UILabel!
    @IBOutlet weak var kotaeha: UILabel!
    @IBOutlet weak var kotaeawase: UIButton!
    @IBOutlet weak var answerBox: UITextField!
    @IBOutlet weak var commentLabel: UILabel!
    
    var answer: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentLabel.textColor = .clear
        commentLabel.backgroundColor = .clear
        // Do any additional setup after loading the view.
        self.answerBox.keyboardType = UIKeyboardType.numberPad
        makeQ()
    }
    
    func makeQ() {
        commentLabel.textColor = .clear
        commentLabel.backgroundColor = .clear
        var x = Int(arc4random_uniform(1000))
        var y = Int(arc4random_uniform(1000))
        let mark = drand48() > 0.5 ? "+" : "-"
        if mark == "+" {
            calcLabel.text = "\(x) + \(y) = ?"
            answer = x + y
        } else {
            // 引き算の時にx<yなら、答えがマイナスにならないようにswapする
            if x < y {
                swap(&x, &y)
            }
            calcLabel.text = "\(x) - \(y) = ?"
            answer = x - y
        }
    }

    @IBAction func checkCalc(_ sender: UIButton) {
        if answer! == Int(answerBox.text!){
            commentLabel.textColor = .black
            commentLabel.text = "GOOD BOY!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.makeQ()
            }
        } else {
            print("you made a mistake")
            
            // call the reset page
            let storyboard: UIStoryboard = self.storyboard!
            let reset = storyboard.instantiateViewController(withIdentifier: "reset")
            self.present(reset, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
