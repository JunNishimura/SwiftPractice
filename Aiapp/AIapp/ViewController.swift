//
//  ViewController.swift
//  AIapp
//
//  Created by 西村純 on 2018/04/27.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTextView: UITextView!
    
    // カメラロールを表示するimagePicker
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        myTextView.text = ""
    }
    
    // photolibararyから画像を参照
    @IBAction func pickPic(_ sender: Any)
    {
        // カメラロールを表示する
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 自分で撮った写真をモデルに使う
    @IBAction func takePic(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // カメラロールを閉じる
        imagePicker.dismiss(animated: true, completion: nil)
        // 選択した画像が存在すれば
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        // イメージビューを表示する
        myImageView.image = image
        
        // make a prediction
        predict(inputImage: image)
    }
    
    func predict(inputImage: UIImage) {
        self.myTextView.text = ""
        
        // make a model for machine learning
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            return
        }
        
        // make a request for the model and show when the results are returned
        let request = VNCoreMLRequest(model: model) {
            request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            
            // バックグラウンドで処理が終わっ時に表示する
            DispatchQueue.main.async {
                for result in results {
                    // if prob is more than 1%, then add on the textView
                    let per = Int(result.confidence * 100)
                    if per >= 1 {
                        let name = result.identifier
                        self.myTextView.text.append("これは、\(name)です。確率は\(per)% \n")
                    }
                }
            }
        }
        
        // convert image to the format which can be fit in the learning model
        guard let ciImage = CIImage(image: inputImage) else {
            return
        }
        let imageHandler = VNImageRequestHandler(ciImage: ciImage)
        
        // 画像予想をバックグラウンドで処理する
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                // execture the prediction of the image
                try imageHandler.perform([request])
            } catch {
                print("エラー\(error)")
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

