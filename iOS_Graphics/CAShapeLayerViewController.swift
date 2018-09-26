//
//  CAShapeLayerViewController.swift
//  iOS_Graphics
//
//  Created by Miguel Gallego Martín on 25/9/18.
//  Copyright © 2018 Miguel Gallego Martín. All rights reserved.
//

import UIKit

class CAShapeLayerViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var segPath: UISegmentedControl!
    @IBOutlet weak var lblAnimTime: UILabel!
    @IBOutlet weak var sliderAnimTime: UISlider!
    
    let shapeLayer = CAShapeLayer()
    var pntCenter = CGPoint.zero
    var animTime: Float = 0.20
    
    enum PathType: Int {
        case circle = 0
        case square
        case rect
        case triangle
    }
    let pathCircle = UIBezierPath()
    var pathSquare: UIBezierPath!
    var pathRect: UIBezierPath!
    var pathTriangle = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pntCenter = CGPoint(x: view.bounds.width / 2.0, y: 100)
        // paths configs
        pathCircle.addArc(withCenter: pntCenter, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        pathSquare = UIBezierPath(rect: CGRect(origin: CGPoint(x: pntCenter.x - 50, y: pntCenter.y - 50), size: CGSize(width: 100, height: 100)))
        pathRect = UIBezierPath(rect: CGRect(origin: CGPoint(x: pntCenter.x - 100, y: pntCenter.y - 50), size: CGSize(width: 200, height: 100)))
        pathTriangle.move(to: CGPoint(x: pntCenter.x - 50, y: pntCenter.y + 50))
        pathTriangle.addLine(to: CGPoint(x: pntCenter.x, y: pntCenter.y - 50))
        pathTriangle.addLine(to: CGPoint(x: pntCenter.x + 50, y: pntCenter.y + 50))
        pathTriangle.close()
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
        animDraw.duration = CFTimeInterval(animTime)
        animDraw.fillMode = kCAFillModeForwards
        animDraw.isRemovedOnCompletion = true
        animDraw.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shapeLayer.add(animDraw, forKey: "drawLayer")
    }

    func getCGPath(withIndex idx: Int) -> CGPath {
        switch idx {
        case PathType.circle.rawValue:  return pathCircle.cgPath
        case PathType.square.rawValue:  return pathSquare.cgPath
        case PathType.rect.rawValue:    return pathRect.cgPath
        case PathType.triangle.rawValue:  return pathTriangle.cgPath
        default:  return pathCircle.cgPath
        }
    }
    
    // MARK: - IBActions
    @IBAction func onBtnPlay(_ sender: UIBarButtonItem) {
        drawShapeLayerAnimated()
    }
    
    @IBAction func onSliderAnimTimeValueChanged(_ sender: UISlider) {
        animTime = sender.value
        lblAnimTime.text = String.init(format: "%1.2f s", animTime)
    }
    
    
    @IBAction func onSegPathValueChanged(_ sender: UISegmentedControl) {  // Transforms path animated
        shapeLayer.removeAllAnimations()
        let anim = CABasicAnimation(keyPath: "path")
        anim.delegate = self
        anim.fromValue = shapeLayer.path
        anim.toValue = getCGPath(withIndex: sender.selectedSegmentIndex)
        anim.duration = CFTimeInterval(animTime)
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shapeLayer.add(anim, forKey: "transAnim")
    }
    
    // MARK: - CAAnimationDelegate
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        shapeLayer.path = getCGPath(withIndex: segPath.selectedSegmentIndex)
    }
   
}
