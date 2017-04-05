//
//  ViewController.swift
//  Calculator
//
//  Created by Aman Luthra on 2/6/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import UIKit;
import Foundation; // Imports some Math Functions and other Stuff
import Darwin; // Imports strictly the Math functions

class ViewController: UIViewController {
    
    var theBrain = CalculatorModel(); // Connection to the Model
    var flag = 0; // Flag to determine for First Button Click or Consecutive Button Click
    var operation: String = ""; // Operation variable
    var sign = true; // Change Sign Flag
    var num1 = 0.0; // Number 1 initializer
    var num2 = 0.0; // Number 2 initializer
    var clickedOnce = true; // Operation Button clicked flag
    var sum = 0.0; // Sum/Result initializer
    var decimalClicked = false; // Decimial Point Flag

    @IBOutlet weak var lblView: UILabel! //Outlet - variable read or write too (Reference to it)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnNumberClick(_ sender: UIButton) { //Adds Number as a string to label
        if flag == 0{
            lblView.text = sender.currentTitle;
            flag = flag + 1;
        } else {
            lblView.text = lblView.text! + sender.currentTitle!;
        }
    }

    @IBAction func btnDecimalPoint(_ sender: UIButton) {
        // Must click 0 before decimal point in order to get 0.___
        if(!decimalClicked){
            lblView.text = lblView.text! + sender.currentTitle!;
            decimalClicked = true;
        }
    }
    
    @IBAction func btnClear(_ sender: UIButton) {
        //Clears Result - Like a reset Button for App
        num1 = 0.0;
        num2 = 0.0;
        lblView.text = "0";
        flag = 0;
        clickedOnce = true;
        decimalClicked = false;
    }
    @IBAction func signChage(_ sender: UIButton) { //Changes Sign
        var number = (Double)(lblView.text!);
        sign = true;
        if sign == true{
            number = number! * -1;
            sign = false;
            lblView.text = (String)(number!);
        }
    }

    @IBAction func percent(_ sender: UIButton) { //Gets Number Out of 100 - Math done with Percent Function in Brain
        num1 = Double(lblView.text!)!;
        let res = theBrain.percent(number: num1);
        lblView.text = String(res);
    }
    
    
    @IBAction func math(_ sender: UIButton) { //Equals Must Be clicked in order for Extra Credit Functions to Work (√, e, π, Sin, Cos, Tan, !)
        if clickedOnce {
            num1 = Double(lblView.text!)!;
            theBrain.num1 = String(num1);
            clickedOnce = false;
            flag = 0;
            operation = sender.currentTitle!;
            lblView.text = "0";
            
        } else {
            num2 = Double(lblView.text!)!;
            theBrain.num1 = String(num1);
            theBrain.num2 = String(num2);
            theBrain.operation = operation;
            sum = theBrain.doOperation(op: theBrain.operation);
            lblView.text = String(sum);
            num1 = sum;
            theBrain.num1 = String(sum);
            clickedOnce = true;
            decimalClicked = false;
        }
    }

}


