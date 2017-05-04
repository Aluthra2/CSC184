//
//  MemoryGameModel.swift
//  MemoryGameProject
//
//  Created by Aman Luthra on 4/19/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import Foundation

struct Node{ //Node for emojis
    var symbol: String; //Emoji item
    var matched: Bool; //Matched or not
    var count = 0; //Counter to count if only 2 emojis were put in place
    
    
    init(symbol: String, matched: Bool, count: Int){ //Constrcutor
        self.symbol = symbol;
        self.matched = matched;
        self.count = count;
    }
    
    init(){ //Overloaed constructor
        self.symbol = "";
        self.matched = false;
        self.count = 0;
    }
    
}

class MemoryGameModel{ //Model
    var gameDecision: Bool; //Game won or not
    var emojis: [String]; //Emoji array
    var gameArray: [[Node]]; //Game array (Matrix) - 2D array
    var nodeArray: [Node]; //Node array
    var size: [Int]; //Size of the board size[0] = row, size[1] = column
    

    init(){ //Constructore
        self.gameDecision = false;
        self.emojis = ["😂", "🤡", "👌🏼", "👍🏼", "👻", "🎩", "🙈", "🏈","🏀", "🎮"];
        self.gameArray = [[Node]]()
        self.nodeArray = [Node]()
        self.size = [Int]();
        
    }

    init(gameDecison:Bool, emojis:[String], gameArr: [[Node]], nodeArray: [Node], sizeArray: [Int]){ //Overloaded constrcutor
        self.gameDecision = gameDecison;
        self.emojis = emojis;
        self.gameArray = gameArr;
        self.nodeArray = nodeArray;
        self.size = sizeArray;
    }
    
    func genArrNode(arr: [String]){ //Generate array of Nodes using string array (emoji array)
        for i in 0..<arr.count {
            var node = Node();
            node.symbol = arr[i];
            node.matched = false;
            nodeArray.append(node)
        }
    }
    
    func randomNum(array: [String]) -> Int{ //Returns a random number based on an array size (emoji array)
        let index = Int(arc4random_uniform(UInt32(array.count)))
        return index;
    }
    
    func getEmoji(tagNum: Int) -> String{ //Gets emoji based off of row and column number
        let column = tagNum%size[1];
        let row = tagNum%size[0];
        return gameArray[row][column].symbol;
    }
    
    func setEmoji() -> String{ //get emoji using random num
        let index = randomNum(array: emojis);
        return emojis[index];
    }
    
    func initializeGame(amount: [Int]){ //Initialize the Game
        size = amount; //pointer to size array
        genArrNode(arr: emojis); //generate array of Nodes
        let matches = (size[0]*size[1])/2; //Number of matches possible in game, used to determine which range of emojis to use for random number function
        var node = Node(); //Create a node
        for _ in 0 ..< size[0] { //Row
            var row = [Node](); //Array of Nodes
            for _ in 0 ..< size[1] { //Column
                let index = Int(arc4random_uniform(UInt32(matches))); //Get random index
                node = nodeArray[index]; //Get node based off of index
                nodeArray[index].count += 1; //Increment value of count in node array
                node.count = nodeArray[index].count; //set node.count equal to nodeArray[index].count
                while(node.count > 2){ //If more than 2
                    let index = Int(arc4random_uniform(UInt32(matches))); //Redraw emoji
                    node = nodeArray[index]; //get random node based off of emoji
                    nodeArray[index].count += 1; //increment node count
                    node.count = nodeArray[index].count; //set node.count equal to nodeArray[index].count
                }
                row.append(node); //add together 1 row
               }
            gameArray.append(row); //Add the row to the game
            }
        //printArray();
    }
    

    
    func printArray(){ //Prints array of emojis in console. (Used for debugging purposes)
        for i in 0 ..< size[0] {
            for j in 0 ..< size[1] {
                print(gameArray[i][j].symbol);
            }
        }
    }
    
    func isMatch(tag1:Int, tag2:Int) -> Bool{ //Checks if two emojis are a match based off of tage number
        let matches = (size[0]*size[1])/2;
        if(getEmoji(tagNum: tag1) == getEmoji(tagNum: tag2)){
            for index in 0 ..< matches {
                if(nodeArray[index].symbol == getEmoji(tagNum: tag1)) {
                    nodeArray[index].matched = true;
                }
            }
            return true;
        } else {
            return false;
        }
    }
    
    func checkWin() -> Bool{ //Checks board for a win.
        let matches = (size[0]*size[1])/2;
        for index in 0 ..< matches {
            if(nodeArray[index].matched == false){
                return false;
            }
        }
        return true;
    }

    
}
