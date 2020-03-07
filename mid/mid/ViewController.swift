//
//  ViewController.swift
//  mid
//
//  Created by Kim Kiori on 3/7/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }
    
    func addGesture() {
        views.forEach {(view) in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTap))
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func viewDidTap(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ColorVC") as ColorViewController
            
            vc.onColorSelected = { [weak self] color in
                guard let self = self else {return}
                view.backgroundColor = color
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
}

