//
//  ViewController.swift
//  lab3
//
//  Created by Kim Kiori on 2/29/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(presentCreateView))
    }

    @objc func presentCreateView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CreateFigureVC") as CreateFigureViewController
        
        vc.onAdd = { [weak self] width, height, x, y, color in
            guard let self = self else { return }
            
            let figure = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            figure.backgroundColor = color
            self.view.addSubview(figure)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.figureDidTap))
            figure.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.figureDidPan(recognizer:)))
            figure.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.figureDidPinch))
            figure.addGestureRecognizer(pinchGestureRecognizer)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func figureDidTap(_ sender: UITapGestureRecognizer) {
        if let figure = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "CreateFigureVC") as CreateFigureViewController
            vc.selectedFigure = figure
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var baseOrigin: CGPoint!
    @objc func figureDidPan(recognizer: UIPanGestureRecognizer) {
        if let figure = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = figure.frame.origin
            case .changed:
                let d = recognizer.translation(in: figure)
                figure.frame.origin.x = baseOrigin.x + d.x
                figure.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
    
    @objc func figureDidPinch(_ sender: UIPinchGestureRecognizer) {
        if let figure = sender.view {
            if sender.state == .began || sender.state == .changed {
                figure.transform = (figure.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
    
}

