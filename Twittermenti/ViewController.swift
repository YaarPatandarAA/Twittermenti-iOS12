//
//  ViewController.swift
//  Twittermenti
//
//  Created by Amarjit Singh on 12/11/2018.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetCount = 100
    let sentimentClassifier = TwitterSentimentClassifier()
    let swifter = Swifter(consumerKey: getAPIKey(), consumerSecret: getSecretKey())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        fetchTweets()
    }
    
    func fetchTweets(){
        if let searchText = textField.text{
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TwitterSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetClassification = TwitterSentimentClassifierInput(text: tweet)
                        tweets.append(tweetClassification)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                print(error)
            }
        }
    }
    func makePrediction(with tweets: [TwitterSentimentClassifierInput]){
        do{
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            var sentimentScore = 0
            
            for pred in predictions{
                let sentiment = pred.label
                
                if sentiment == "Pos"{
                    sentimentScore += 1
                }
                else if sentiment == "Neg"{
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
        }
        catch{
            print(error)
        }
    }
    func updateUI(with sentimentScore: Int){
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        }
        else if sentimentScore > 10 {
            self.sentimentLabel.text = "😁"
        }
        else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        }
        else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        }
        else if sentimentScore > -10 {
            self.sentimentLabel.text = "😠"
        }
        else if sentimentScore > -20 {
            self.sentimentLabel.text = "🤬"
        }
        else{
            self.sentimentLabel.text = "🤮"
        }
    }
}
