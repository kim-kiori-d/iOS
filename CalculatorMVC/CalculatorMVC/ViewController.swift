//
//  ViewController.swift
//  CalculatorMVC
//
//  Created by Kim Kiori on 1/25/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let calculator = Calculator()
    var isUserTyping = true
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let numberText = sender.titleLabel?.text else { return }
        
        if isUserTyping {
            let currentNumber = resultLabel.text!
            resultLabel.text = currentNumber + numberText
        } else {
            resultLabel.text = numberText
            isUserTyping = true
        }
        
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let numberText = resultLabel.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
        else {
            return
            
        }
    
        calculator.setOperands(number: number)
        calculator.execute(symbol: operation)
        resultLabel.text = "\(calculator.result)"
        isUserTyping = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    


}

