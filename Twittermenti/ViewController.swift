//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    let sentimentClassifier = TwitterSentimentClassifier()
    var searchWhat = ""
    
    let swifter = Swifter(consumerKey: getAPIKey(), consumerSecret: getSecretKey())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: searchWhat, lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            print(results)
        }) { (error) in
            print(error)
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

