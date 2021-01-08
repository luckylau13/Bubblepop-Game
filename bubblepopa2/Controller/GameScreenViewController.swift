//
//  GreenViewController.swift
//  bubblepopa2
//
//  Created by Lucky Lau on 10/5/20.
//  Copyright © 2020 Lucky Lau. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {

    
    var myTimer: Timer?
    var bubble = Bubble()
    var bubbleArray = [Bubble]()
    var remainingSeconds = 60 //Adjustable in settings
    var maxBubbleNumber = 15 //Adjustable in settings
    var score: Double = 0
    var lastBubbleValue: Double = 0
    //var audioPlayer: AVAudioPlayer!
    var playerName: String = ""
    var rankDict = [String : Double]()
    var previousRankDict: Dictionary? = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    
   var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousRankDict = UserDefaults.standard.dictionary(forKey: "ranking") as? Dictionary<String, Double>
        if previousRankDict != nil {
            rankDict = previousRankDict!
            sortedHighScoreArray = rankDict.sorted(by: {$0.value > $1.value})
        }
        
    /*    let popSound = Bundle.main.url(forResource: "bubblePop", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: popSound!)
            audioPlayer.prepareToPlay()
                catch let error as NSError {
                    print(error.debugDescription)
                
            }
            
        } */
        
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            timer in
            //Do something
            self.setRemainingTime()
            self.removeBubble()
            self.createBubble()
        }
    }
    
    @IBAction func bubbleTapped(_ bubbleClicked: Bubble){
        //pay audio
        //audioPlayer.play()
        
        //remove the button form screen
        bubbleClicked.removeFromSuperview()
       
        
       //checking for combo
        if lastBubbleValue == bubbleClicked.value{
            //is combo
            score += bubbleClicked.value * 1.5 //correct outcome is 10, 15, 15, 15
        }
        else{
            //not combo
            score += bubbleClicked.value
        }
        lastBubbleValue = bubbleClicked.value
        
        //updating current score
        currentScore.text = "\(score)"
        
        //check and update high score
        if previousRankDict == nil{
            highScore.text = "\(score)"
        } else if sortedHighScoreArray[0].value < score{
            highScore.text = "\(score)"
        } else if sortedHighScoreArray[0].value >= score{
            highScore.text = "\(sortedHighScoreArray[0].value)"
        }
        
    }
    
    @objc func removeBubble(){
        var i = 0
        while i < bubbleArray.count{
            //If less than 33% chance
            
            if arc4random_uniform(100) < 33{
                let bubbleToBeRemoved = bubbleArray[i]
                //remove button from SuperView
                bubbleToBeRemoved.removeFromSuperview()
                //remove button from array
                bubbleArray.remove(at: i)
                //For loop
                i += 1
            }
        }
    }
    
    func saveHighScore(){
                   rankDict.updateValue(score, forKey: "\(playerName)")
                   UserDefaults.standard.set(rankDict, forKey:"ranking")
               }
           
           //Update HighScore
               
               func checkHighScoreExist() {
                   if previousRankDict == nil {
                       saveHighScore()
                   } else {
                       rankDict = previousRankDict!
                       if rankDict.keys.contains("\(playerName)") {
                           let currentScore = rankDict["\(playerName)"]!
                           if currentScore < score {
                               saveHighScore()
                           }
                       } else {
                           saveHighScore()
                       }
                   }
               }
    

    @objc func setRemainingTime(){
        //Update Label
        timeLeft.text = "\(remainingSeconds)"
       
        //Check if game ended?
        if (remainingSeconds == 0){
        //stop timere
        myTimer!.invalidate()
        checkHighScoreExist()
        
        //Navigate to High Score
        let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController") as! HighScoreViewController
        self.navigationController?.pushViewController(destinationView, animated: true)
//        present(destinationView,animated: true, completion: nil)
        } else {
            remainingSeconds -= 1
        }

    }
    
    
    
    func isOverlapped(newBubble: Bubble ) -> Bool {
        for existingBubble in bubbleArray{
            if newBubble.frame.intersects(existingBubble.frame){
                return true
            }
        }
        return false
    }
    
    
    
    @objc func createBubble(){
               //20
               //5 left
               //Max Number new bubble = 20 -5 = 15
               //numberToCreate = random between 1 ~ 10
        let numberToCreate = arc4random_uniform(UInt32(maxBubbleNumber - bubbleArray.count)) + 1
               var i = 0
        
        while i < numberToCreate {
            //Create Bubble
            bubble = Bubble() //UIButton
            
            //set Position
            bubble.frame = createRandomRect()
            
            //check position for overlap
            if !isOverlapped(newBubble: bubble){
                // Set onClick method
                bubble.addTarget(self, action: #selector(bubbleTapped), for: UIControl.Event.touchUpInside)
                
                //add the bubble to our View
                self.view.addSubview(bubble)
                
                //Animate
                bubble.animate()
                
                //for Loop
                i += 1
                //Add bubble to bubbleArray
                bubbleArray += [bubble]
                
                              
                
            }
        }
               
    }
    
    func createRandomRect() -> CGRect {
        let diameter = 2 * bubble.radius;
        let randomX = CGFloat(10 + arc4random_uniform(screenWidth - diameter - 20))
        let randomY = CGFloat(160 + arc4random_uniform(screenHeight - diameter - 180 ))
        return CGRect(x: randomX,
                      y: randomY,
                      width: CGFloat(diameter),
                      height: CGFloat(diameter))
    }
    
   
   
}
