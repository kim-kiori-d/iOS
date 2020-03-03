//
//  CreateFigureViewController.swift
//  lab3
//
//  Created by Kim Kiori on 3/3/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class CreateFigureViewController: UIViewController {
    
    var color: UIColor?
    var selectedFigure: UIView?
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func colorButton(_ sender: UIButton) {
        
        buttons.forEach {(button) in
            if button == sender {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
        guard let bgColor = sender.backgroundColor else {return}
        color = bgColor
    }
    
    var onAdd: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
    
    override func viewWillAppear(_ animated: Bool) {
  
        openViewData()
        configureNav()
    }
    
    @objc func deleteFigure() {
        guard let figure = selectedFigure else {return}
        figure.removeFromSuperview()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveFigure() {
        
        guard let width = widthTextField.text, let height = heightTextField.text, let x = xTextField.text, let y = yTextField.text, let color = color else {
            let alert = UIAlertController(title: "Error", message: "Fill all data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let widthDouble = Double(width), let heightDouble = Double(height), let xDouble = Double(x), let yDouble = Double(y) else {
            let alert = UIAlertController(title: "Error", message: "Not correct data type", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let screenSize = UIScreen.main.bounds
        
        if CGFloat(widthDouble) > screenSize.width || CGFloat(heightDouble) > screenSize.height {
            let alert = UIAlertController(title: "Error", message: "Data is bigger than view", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let figure = selectedFigure else {
            onAdd?(widthDouble, heightDouble, xDouble, yDouble, color)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        figure.backgroundColor = color
        figure.frame = CGRect(x: CGFloat(xDouble), y: CGFloat(yDouble), width: CGFloat(widthDouble), height: CGFloat(heightDouble))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureNav(){
        let deleteButton = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deleteFigure))
        let addButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveFigure))
        
        guard let figure = selectedFigure else {
             navigationItem.rightBarButtonItems = [ addButton]
            return
        }
        navigationItem.rightBarButtonItems = [deleteButton, addButton]
       
    }
    
    func openViewData(){
        
        guard let figure = selectedFigure else {return}
        print(figure.frame.width)
        self.widthTextField.text = figure.frame.width.description
        self.heightTextField.text = figure.frame.height.description
        self.xTextField.text = figure.frame.origin.x.description
        self.yTextField.text = figure.frame.origin.y.description
        
        buttons.forEach {(button) in
            if button.backgroundColor == figure.backgroundColor {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
