//
//  ColorViewController.swift
//  mid
//
//  Created by Kim Kiori on 3/7/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet var colorViews: [UIView]!
    
    var onColorSelected:((_ color: UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
    }
    
    func addGesture() {
        colorViews.forEach {(view) in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.colorDidTap))
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func colorDidTap(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            onColorSelected?(view.backgroundColor ?? .white)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
