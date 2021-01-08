//
//  BlueViewController.swift
//  bubblepopa2
//
//  Created by Lucky Lau on 10/5/20.
//  Copyright © 2020 Lucky Lau. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/{
    
    

    @IBOutlet weak var navBar: UINavigationItem!
   /* @IBOutlet weak var highScoreTableView: UITableView!*/
    
    
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player3: UILabel!
    @IBOutlet weak var player4: UILabel!
    @IBOutlet weak var player5: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score3: UILabel!
    @IBOutlet weak var score4: UILabel!
    @IBOutlet weak var score5: UILabel!
    
    // function load data
  var rankingDictionary = [String : Double]()
  var sortedHighScoreArray = [(key: String, value: Double)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as! [String : Double]? {
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
            
            if sortedHighScoreArray.count == 1 {
                player1.text = sortedHighScoreArray[0].key
                score1.text = "\(sortedHighScoreArray[0].value)"
            } else if sortedHighScoreArray.count == 2 {
                player1.text = sortedHighScoreArray[0].key
                player2.text = sortedHighScoreArray[1].key
                score1.text = "\(sortedHighScoreArray[0].value)"
                score2.text = "\(sortedHighScoreArray[1].value)"
            } else if sortedHighScoreArray.count == 3{
                player1.text = sortedHighScoreArray[0].key
                player2.text = sortedHighScoreArray[1].key
                player3.text = sortedHighScoreArray[2].key
                score1.text = "\(sortedHighScoreArray[0].value)"
                score2.text = "\(sortedHighScoreArray[1].value)"
                score3.text = "\(sortedHighScoreArray[2].value)"
            } else if sortedHighScoreArray.count == 4 {
                player1.text = sortedHighScoreArray[0].key
                player2.text = sortedHighScoreArray[1].key
                player3.text = sortedHighScoreArray[2].key
                player4.text = sortedHighScoreArray[3].key
                score1.text = "\(sortedHighScoreArray[0].value)"
                score2.text = "\(sortedHighScoreArray[1].value)"
                score3.text = "\(sortedHighScoreArray[2].value)"
                score4.text = "\(sortedHighScoreArray[3].value)"
            } else {
            player1.text = sortedHighScoreArray[0].key
            player2.text = sortedHighScoreArray[1].key
            player3.text = sortedHighScoreArray[2].key
            player4.text = sortedHighScoreArray[3].key
            player5.text = sortedHighScoreArray[4].key
            score1.text = "\(sortedHighScoreArray[0].value)"
            score2.text = "\(sortedHighScoreArray[1].value)"
            score3.text = "\(sortedHighScoreArray[2].value)"
            score4.text = "\(sortedHighScoreArray[3].value)"
            score5.text = "\(sortedHighScoreArray[4].value)"
            }
       }
    }
    // tabelview delegate method
  /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedHighScoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        //retrieve High Score Data
        if let rankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as! [String : Double]? {
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
            
        }
        let currentIndex = indexPath.row;
        let currentScore = sortedHighScoreArray[currentIndex];
        
        //Display data
        cell.textLabel?.text = currentScore.key
        cell.detailTextLabel?.text = "\(currentScore.value)"
        return cell;
    }*/
 
    

   

}

