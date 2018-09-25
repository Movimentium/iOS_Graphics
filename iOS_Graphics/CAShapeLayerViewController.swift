//
//  CAShapeLayerViewController.swift
//  iOS_Graphics
//
//  Created by Miguel Gallego Martín on 25/9/18.
//  Copyright © 2018 Miguel Gallego Martín. All rights reserved.
//

import UIKit

class CAShapeLayerViewController: UIViewController {

    let shapeLayer = CAShapeLayer()
    var pntCenter = CGPoint.zero
    
    let pathCircle = UIBezierPath()
//    var pathRect: UIBezierPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pntCenter = CGPoint(x: view.bounds.width / 2.0, y: 100)
        
        pathCircle.addArc(withCenter: pntCenter, radius: 50.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        setupShapeLayer()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.addSublayer(shapeLayer)
        drawShapeLayerAnimated()
    }
    
    func setupShapeLayer() {
        shapeLayer.path = pathCircle.cgPath              // getSelectedCGPath()  TODO
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineCap = kCALineCapRound
    }
    
    func drawShapeLayerAnimated() {
        shapeLayer.removeAllAnimations()
        let animDraw = CABasicAnimation(keyPath: "strokeEnd")
        animDraw.fromValue = 0.0
        animDraw.toValue = 1.0
        animDraw.fillMode = kCAFillModeForwards
        animDraw.isRemovedOnCompletion = true
        animDraw.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shapeLayer.add(animDraw, forKey: "drawLayer")
    }

    
    // MARK: - IBActions
    @IBAction func onBtnPlay(_ sender: UIBarButtonItem) {
        drawShapeLayerAnimated()
    }
    
    
   
}
