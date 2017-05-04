//
//  EasyViewController.swift
//  MemoryGameProject
//
//  Created by Aman Luthra on 5/1/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import UIKit
import CoreData

class EasyViewController: UIViewController { //All view controllers follow same format but different initialization numbers
    
    let brain = MemoryGameModel(); //Connection to Model
    var flag: Int = 0; //Flag for button click
    var prevButton: UIButton? = nil; //Previous Button click
    var currentButton: UIButton? = nil; //Current Button click
    var clicked: Bool = false; //Flag for double click bug
    var currentTag: Int = 0; //Current tag from current Button
    var previousTag: Int = 0; //Previous tag from previous button
    
    @IBOutlet weak var hScoreCounter: UILabel! //High score counter label
    @IBOutlet weak var cScoreCounter: UILabel! //Current score counter label
    @IBOutlet weak var mLeftCounter: UILabel! //Moves Left counter Label
    @IBOutlet weak var movesLeft: UILabel! //Moves Left Label
    @IBOutlet weak var movesMade: UILabel! //Moves Made Label
    @IBOutlet weak var mMadeCounter: UILabel! //Moves Made Counter Label
    @IBOutlet weak var currentScore: UILabel! //Current Score Label
    @IBOutlet weak var highScore: UILabel! //High Score Label
    

    override func viewDidLoad() {
        super.viewDidLoad()
        brain.initializeGame(amount: [2,2]); //Initialize Game
        mLeftCounter.text! = String(7); //Initialize Moves Left
        mMadeCounter.text! = String(0); //Initialize Moves Made
        cScoreCounter.text! = String(0); //Initialize Current Score

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backToRoot(){ //UIAlert Handler to go back to previous view
        _ = navigationController?.popViewController(animated: true);
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) { //BtnClick
        
        func flipImage(_ button: UIButton) -> String { //Helper Function
            let tag = button.tag;
            let emoji = brain.getEmoji(tagNum: tag); //Get emoji from brain using tag
            return emoji;
        }
        
        func winResult() { //Win Action
            let result = brain.checkWin(); //Check for win in Model
            if(result == true){
                saveHighScore();
                let myAlert = UIAlertController(title: "You Win!", message: nil, preferredStyle: UIAlertControllerStyle.alert); //Message of alert box
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in self.backToRoot()})) //handler takes it back to previous view
                self.present(myAlert, animated: true, completion: nil); //Present alert box
            }
        }
        func loseResult() {//Lose Action
            let myAlert = UIAlertController(title: "You Lose!", message: nil, preferredStyle: UIAlertControllerStyle.alert); //Message of alert box
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in self.backToRoot()})) //handler takes it back to previous view
            self.present(myAlert, animated: true, completion: nil); //Present alert box
        }
        
        func decrementMovesLeft() { //Decrement Moves Left
            var count:Int? = Int(mLeftCounter.text!);
            count!-=1;
            mLeftCounter.text! = String(describing: count!);
            if(mLeftCounter.text! == "0"){
                loseResult(); //Perform lose action if no more moves left
            }
        }
        
        func incrementMovesMade() { //Increment Moves Made
            var count:Int? = Int(mMadeCounter.text!);
            count!+=1;
            mMadeCounter.text! = String(describing: count!);
        }
        
        func incrementScore(){ //Increment current Score
            var count:Int? = Int(cScoreCounter.text!);
            count!+=1;
            cScoreCounter.text! = String(describing: count!);
        }
        
        func saveHighScore(){//Save High Score
            let count:Int? = Int(cScoreCounter.text!);
            hScoreCounter.text! = String(describing: count!);
        }
    
        let currentImage = sender.image(for: UIControlState.normal); //Save image of "?"
        if(flag == 0){
            sender.setImage(nil, for: UIControlState.normal) //Erase image
            prevButton = sender; //Assign Value
            sender.setTitle(flipImage(prevButton!), for: UIControlState.normal); //Get Emoji
            flag += 1;
            previousTag = sender.tag; //Get Tag
        } else if (flag == 1){
            sender.setImage(nil, for: UIControlState.normal) //Erase image
            currentButton = sender; //Assign value
            sender.setTitle(flipImage(currentButton!), for: UIControlState.normal) //Get Emoji
            flag += 1;
            currentTag = sender.tag; //Get tag
        } else {
            if(brain.isMatch(tag1: previousTag, tag2: currentTag)){ //Check for match and if true do:
                currentButton?.setTitle(nil, for: UIControlState.normal); //Disappear emoji
                prevButton?.setTitle(nil, for: UIControlState.normal); //Dissappear emoji
                sender.setImage(nil, for: UIControlState.normal) //Set current button image to nothing
                decrementMovesLeft(); //Decrement Moves Left
                incrementMovesMade(); //Increment Moves Made
                incrementScore(); //Increment Score
                prevButton = sender; //Assign new Value
                previousTag = prevButton!.tag; //Get tag of new value
                sender.setTitle(flipImage(prevButton!), for: UIControlState.normal) //Get emoji
                flag = 1; //Reset flag
                winResult(); //Check for win
            } else {
                currentButton?.setImage(currentImage, for: UIControlState.normal); //Reset Image of 1st button back to "?"
                prevButton?.setImage(currentImage, for: UIControlState.normal); //Reset Image of 2nd button back to "?"
                decrementMovesLeft(); //Decrement Moves Left
                incrementMovesMade(); //Increment Moves Made
                sender.setImage(nil, for: UIControlState.normal) //Set current button image to nothing
                prevButton = sender; //Assign new value to prev button
                previousTag = prevButton!.tag; //Get tag value of new button
                sender.setTitle(flipImage(prevButton!), for: UIControlState.normal) //Get emoji
                flag = 1;//Reset Flag
            }
        }
        
        
    }
}


