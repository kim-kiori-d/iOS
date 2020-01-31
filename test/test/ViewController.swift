//
//  ViewController.swift
//  test
//
//  Created by Kim Kiori on 1/18/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var number: Int = 0
    var result: Int = 0
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        textField.text = String(sender.tag)
        number = sender.tag
        
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        textField.text = ""
        result+=number 
        number = 0
    }
    
    @IBAction func equalPressed(_ sender: Any) {
        result+=number
        textField.text = String(result)
        result = 0
        number = 0
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

