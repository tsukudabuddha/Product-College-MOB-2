//
//  ViewController.swift
//  RandomJoke
//
//  Created by Andrew Tsukuda on 10/30/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit

enum RequestMethod: String {
    case get = "GET"
}

typealias JSON = [String: Any]

class ViewController: UIViewController {

    @IBOutlet weak var jokeButton: UIButton!
    @IBOutlet weak var jokeTextView: UITextView!
    
    var setup: String?
    var punchLine: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showJoke(_ sender: Any) {
        if jokeTextView.text == "Click Button for new joke" {
            let url = URL(string: "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_joke")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, res, err) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let jsonObject = json as! JSON? {
                        self.setup = jsonObject["setup"] as? String
                        self.punchLine = jsonObject["punchline"] as? String
                    }
                    DispatchQueue.main.async {
                        if let setup = self.setup {
                            self.jokeTextView.text = setup
                            
                        }
                    }
                }
            }
            task.resume()
            self.jokeTextView.text = self.setup
        } else {
            self.jokeTextView.text = (self.setup! + "\n" + self.punchLine!)
        }
        
    }
        
    
}

