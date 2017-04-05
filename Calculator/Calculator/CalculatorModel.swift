//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Aman Luthra on 3/10/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import Foundation; // Imports some Math Functions and other Stuff
import Darwin; // Imports strictly the Math functions

class CalculatorModel{
    var num1: String; //Properties of the Class - All defaulted to internal
    var num2: String;
    var sum: Double;
    var operation: String;
    
    init(){ //Constructor
        self.num1 = "";
        self.num2 = "";
        self.sum = 0.0;
        self.operation = "";
    }
    
    init(number1:String, number2:String, total:String){ //Overloaded Constructor
        self.num1 = number1;
        self.num2 = number2;
        self.sum = Double(total)!;
        self.operation = "";
    }
    
    func factorial(Number: Double) -> Double{ //Factorial Definition
        var result = 0.0;
        if(Number == 0){
             result = 1;
        } else {
            result = Number * factorial(Number: Number-1);
        }
        return result;
    }
    
    func doOperation(op: String) -> Double { // All Math Operation Functions
        let first = Double(num1)!; // Function Properties
        let second = Double(num2)!;
        var res = sum;
        
        switch op { // Used switch statement accoriding to project specs
        case "/":
            res = first/second;
        case "+":
            res = first + second;
        case "-":
            res = first - second;
        case "X":
            res = first * second;
        case "^": // Exponent
            var x = 0.0;
            res = Double(num1)!;
            while  x != (Double(num2)! - 1){
                res = res * Double(num1)!;
                x = x + 1;
            } // All Extra Credit Functions start from here
        case "!":
            res = factorial(Number: first); // !
        case "e":
            res = first * 2.718281828459; // e
        case "π":
            res = first * Double.pi; // π
        case "√":
            res = sqrt(first); // √
        case "3√":
            res = pow(first, 1/3) // 3√
        case "Sin":
            res = sin(first); // Sin - In Radian Mode
        case "Cos":
            res = cos(first); // Cos - In Radian Mode
        case "Tan":
            res = tan(first); // Tan - In radian Mode
        default:
            return res;
        }
        return res; // Returns res from specific operation call
                    // I did this so I didn't have to write "return res" 100x
    }
   
    func percent(number: Double) -> Double { //Percent Function
        var res: Double;
        res = number/100;
        return res;
    }
    
    
    
    
    
    
    
}
