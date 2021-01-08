//
//  YellowViewController.swift
//  bubblepopa2
//
//  Created by Lucky Lau on 9/5/20.
//  Copyright © 2020 Lucky Lau. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    
    var gameDuration: Int = 60
    var bubbleNum: Int = 15

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var bubbleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        nameText.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    //        if let vcduration = segue.destination as? GameScreenViewController{
    //            vcduration.remainingSeconds = gameDuration
    //        }
    //        if let vcbubble = segue.destination as? GameScreenViewController{
    //            vcbubble.maxBubbleNumber = bubbleNum
    //        }
    //        if let vcname = segue.destination as? GameScreenViewController{
    //            vcname.playerName = name
    //        }
            if segue.identifier == "Start" {
                let destination = segue.destination as! GameScreenViewController
                destination.maxBubbleNumber = bubbleNum
                destination.remainingSeconds = gameDuration
                destination.playerName = nameText.text!
            }
            
        }
    
    
    @IBAction func durationSlider(_ sender: UISlider) {
        
          gameDuration = Int(durationLabel.text!) ?? 0
          durationLabel.text = String(Int(sender.value))
           
       }
       
    @IBAction func bubbleSlider(_ sender: UISlider) {
           bubbleNum = Int(bubbleLabel.text!) ?? 0
           bubbleLabel.text = String(Int(sender.value))
       }
    
    
//    @IBAction func startGame(_ sender: UIButton) {
//        gameDuration = Int(durationLabel.text!) ?? 0
//        bubbleNum = Int(bubbleLabel.text!) ?? 0
//
//    }
    
    func textFReturn(_ textField: UITextField) -> Bool {
        if let currentText = textField.text {
            if currentText.count > 10 {
                textField.deleteBackward()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
    
}
