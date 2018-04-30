//
//  DetailViewController.swift
//  RssReader
//
//  Created by 西村純 on 2018/04/29.
//  Copyright © 2018年 西村純. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
 
    @IBOutlet weak var webView: WKWebView!
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
}

