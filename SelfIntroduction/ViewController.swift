//
//  ViewController.swift
//  SelfIntroduction
//
//  Created by 西村純 on 2018/05/01.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let mainMenu = ["profile", "hobby", "school", "contact"]
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
//
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index path is \(indexPath.row)")
        
//        switch indexPath.row {
//        case 0:
//
//        case 1:
//
//        case 2:
//
//        case 3:
//
//        default:
//            print("error")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.imageCell.image = UIImage(named: mainMenu[indexPath.row])
        cell.labelCell.text = mainMenu[indexPath.row].capitalized
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as! DetailViewController
//        controller.title = mainMenu[]
//    }
}

