//
//  MediumViewController.swift
//  MemoryGameProject
//
//  Created by Aman Luthra on 5/1/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import UIKit

class MediumViewController: UIViewController {
    
    let brain = MemoryGameModel();
    var flag: Int = 0;
    var prevButton: UIButton? = nil;
    var currentButton: UIButton? = nil;
    var clicked: Bool = false;
    var currentTag: Int = 0;
    var previousTag: Int = 0;
    
    @IBOutlet weak var hScoreCounter: UILabel!
    @IBOutlet weak var cScoreCounter: UILabel!
    @IBOutlet weak var mLeftCounter: UILabel!
    @IBOutlet weak var movesLeft: UILabel!
    @IBOutlet weak var movesMade: UILabel!
    @IBOutlet weak var mMadeCounter: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        brain.initializeGame(amount: [4,3]);
        brain.printArray();
        mLeftCounter.text! = String(20);
        mMadeCounter.text! = String(0);
        cScoreCounter.text! = String(0);
        hScoreCounter.text! = String(0);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flipImage(_ button: UIButton) -> String {
        let tag = button.tag;
        let emoji = brain.getEmoji(tagNum: tag);
        return emoji;
    }
    
    func backToRoot(){
        _ = navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        func winResult() {
            let result = brain.checkWin();
            if(result == true){
                saveHighScore();
                let myAlert = UIAlertController(title: "You Win!", message: nil, preferredStyle: UIAlertControllerStyle.alert);
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in self.backToRoot()}))
                self.present(myAlert, animated: true, completion: nil);
            }
        }
        func loseResult() {
            let myAlert = UIAlertController(title: "You Lose!", message: nil, preferredStyle: UIAlertControllerStyle.alert);
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in self.backToRoot()}))
            self.present(myAlert, animated: true, completion: nil);
        }
        
        func decrementMovesLeft() {
            var count:Int? = Int(mLeftCounter.text!);
            count!-=1;
            mLeftCounter.text! = String(describing: count!);
            if(mLeftCounter.text! == "0"){
                loseResult();
            }
        }
        
        func incrementMovesMade() {
            var count:Int? = Int(mMadeCounter.text!);
            count!+=1;
            mMadeCounter.text! = String(describing: count!);
        }
        
        func incrementScore(){
            var count:Int? = Int(cScoreCounter.text!);
            count!+=1;
            cScoreCounter.text! = String(describing: count!);
        }
        
        func saveHighScore(){//Save High Score
            let count:Int? = Int(cScoreCounter.text!);
            hScoreCounter.text! = String(describing: count!);
        }

        
        
        let currentImage = sender.image(for: UIControlState.normal);
        if(flag == 0){
            sender.setImage(nil, for: UIControlState.normal)
            prevButton = sender;
            sender.setTitle(flipImage(prevButton!), for: UIControlState.normal);
            flag += 1;
            previousTag = sender.tag;
        } else if (flag == 1){
            sender.setImage(nil, for: UIControlState.normal)
            currentButton = sender;
            sender.setTitle(flipImage(currentButton!), for: UIControlState.normal)
            flag += 1;
            currentTag = sender.tag;
        } else {
            if(brain.isMatch(tag1: previousTag, tag2: currentTag)){
                currentButton?.setTitle(nil, for: UIControlState.normal); //Disappear emoji
                prevButton?.setTitle(nil, for: UIControlState.normal); //Dissappear emoji
                sender.setImage(nil, for: UIControlState.normal)
                decrementMovesLeft();
                incrementMovesMade();
                incrementScore();
                prevButton = sender;
                previousTag = prevButton!.tag;
                sender.setTitle(flipImage(prevButton!), for: UIControlState.normal)
                flag = 1;
                winResult();
            } else {
                currentButton?.setImage(currentImage, for: UIControlState.normal);
                prevButton?.setImage(currentImage, for: UIControlState.normal);
                decrementMovesLeft();
                incrementMovesMade();
                sender.setImage(nil, for: UIControlState.normal)
                prevButton = sender;
                previousTag = prevButton!.tag;
                sender.setTitle(flipImage(prevButton!), for: UIControlState.normal)
                flag = 1;
            }
        }
        
        
    }
    
    
    
    
    
    
}
