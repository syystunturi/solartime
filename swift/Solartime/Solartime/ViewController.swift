//
//  ViewController.swift
//  Solartime
//
//  Created by Jari Lammi on 28.9.2014.
//  Copyright (c) 2014 Jari Lammi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var WebPage: UIWebView!
    var URLPath = "http://bach.fi/swift/"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAddressURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadAddressURL(){
        let requestURL = NSURL(string:URLPath)
        let request = NSURLRequest(URL:requestURL)
        WebPage.loadRequest(request)
    }
}

