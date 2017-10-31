//
//  ViewController.swift
//  AirBnB
//
//  Created by Andrew Tsukuda on 10/27/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let networking = Networking()
        networking.getListing() { (res) in
//            print(res)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

