//
//  ViewController.swift
//  simple-calc
//
//  Created by Barron, Brandon on 4/22/16.
//  Copyright © 2016 Barron, Brandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var operand1 : String? = nil // left operand(s)
    var operand2 : String? = nil // right operand
    var op : String? = nil // operator
    var opDisplay = ""
    var count = 1
    var total = 0
    
    let basicOps = ["+", "-", "*", "/", "%"]
    let operators = ["count", "avg", "fact"]
    
    
    private func modifyDisplay(n : String) {
        if op == nil {
            if operand1 == nil {
                operand1 = n
                opDisplay = n
            } else {
                operand1! += n
                opDisplay += n
            }
        } else if op != "fact" {
            operand2 = operand2 == nil ? n : operand2! + n
            opDisplay += operand2!
        }
        display.text = opDisplay
    }
    
    private func setOp(operation : String) {
        if operand1 != nil {
            if op == nil && basicOps.contains(operation) {
                op = operation
                opDisplay += op!
            } else if op == nil || operators.contains(operation) {
                switch operation {
                case "count":
                    op = "count"
                    count += 1
                    operand2 = nil
                case "avg":
                    op = "avg"
                    count += 1
                    if operand2 == nil {
                        total += (operand1?.intValue)!
                    } else {
                        total += (operand2?.intValue)!
                        operand2 = nil
                    }
                case "fact":
                    op = "fact"
                default:
                    break
                }
                opDisplay += op!
            }
            display.text = opDisplay
        }
    }
    
    private func calculate() -> Int {
        let op1Num = operand1?.intValue
        let op2Num = operand2 == nil ? 0 : operand2?.intValue
        var result = 0
        
        switch op! {
        case "+":
            result = op1Num! + op2Num!
        case "-":
            result = op1Num! - op2Num!
        case "*":
            result = op1Num! * op2Num!
        case "/":
            result = op1Num! / op2Num!
        case "%":
            result = op1Num! % op2Num!
        case "count":
            result = count
        case "avg":
            result = (total + op2Num!) / count
        case "fact":
            result = 1
            for i in 1 ... op1Num! {
                result *= i
            }
        default:
            break
        }
        
        return result
    }
    
    @IBAction func onOpButtonClicked(sender: UIButton) {
        let buttonText = sender.titleLabel!.text!
        if basicOps.contains(buttonText) || operators.contains(buttonText) {
            setOp(buttonText)
        } else {
            modifyDisplay(buttonText)
        }
    }
    
    @IBAction func onEqualsButtonClicked(sender: UIButton) {
        if operand1 != nil && op != nil {
            let ans = calculate()
            //HistoryContainer.sharedContainer.history?.append(opDisplay + " = " + String(ans))
            HistoryContainer.sharedContainer.addToHistory(opDisplay + " = " + String(ans))
            opDisplay = String(ans)
            display.text = opDisplay
            reset()
        }
    }
    
    @IBAction func onClearButtonClicked(sender: UIButton) {
        opDisplay = ""
        display.text = opDisplay
        reset()
    }
    
    private func reset() {
        operand1 = nil
        operand2 = nil
        op = nil
        total = 0
        count = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// add number formatting to strings
extension String {
    struct NumberFormatter {
        static let instance = NSNumberFormatter()
    }
    var intValue : Int? {
        return NumberFormatter.instance.numberFromString(self)?.integerValue
    }
}

