//
//  CustomLoading.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 26/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable class CustomLoading: UIView {

    fileprivate let animateDuration = 1.0
    fileprivate let kStrokeEnd = "strokeEnd"
    fileprivate let kRotation = "transform.rotation"

    fileprivate var innerOrigin: CGPoint {
        return CGPoint(x: innerSize / 2, y: innerSize / 2)
    }

    fileprivate var innerSize: CGFloat {
        return min(frame.size.height, frame.size.width)
    }

    fileprivate var animatedLayer: CAShapeLayer = CAShapeLayer()

    @IBInspectable var color: UIColor = UIColor.white { didSet { drawRing() }}

    fileprivate var lineWidth: CGFloat = 4

    // MARK: - Override & Initializers

    convenience init(size: CGFloat = 32, color: UIColor = .white, lineWidth: CGFloat = 4) {
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        self.init(frame: frame)
        self.color = color
        self.lineWidth = lineWidth
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        initializeSubViews()
        if self.layer.sublayers != nil {
            for layer: CALayer in self.layer.sublayers! {
                layoutSublayers(of: layer)
            }
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }

    fileprivate func initializeSubViews() {
        for subView: UIView in self.subviews {
            subView.removeFromSuperview()
        }
        if self.layer.sublayers != nil {
            for subLayer: CALayer in self.layer.sublayers! {
                subLayer.removeFromSuperlayer()
            }
        }

        drawRing()
    }

    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }

    func startAnimating() {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animateDuration
        animationGroup.repeatCount = .infinity

        let strokeAnimation = CABasicAnimation(keyPath: kStrokeEnd)
        strokeAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        strokeAnimation.duration = animateDuration / 2
        strokeAnimation.autoreverses = true
        strokeAnimation.fromValue = 0.25
        strokeAnimation.toValue = 0.75

        let rotateAnimation = CABasicAnimation(keyPath: kRotation)
        rotateAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        rotateAnimation.duration = animateDuration
        rotateAnimation.toValue = CGFloat.pi * 2

        animationGroup.animations = [strokeAnimation, rotateAnimation]

        animatedLayer.add(animationGroup, forKey: "loading")
    }

    fileprivate func drawRing() {
        let radius = (innerSize / 2)
        let startAngle = CGFloat(-(Double.pi / 2))
        let endAngle = CGFloat(Double.pi) - startAngle

        let circlePath = UIBezierPath(arcCenter: innerOrigin, radius: radius - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true)

        animatedLayer.path = circlePath.cgPath
        animatedLayer.lineCap = kCALineCapRound
        animatedLayer.lineJoin = kCALineJoinBevel
        animatedLayer.fillColor = UIColor.clear.cgColor
        animatedLayer.strokeColor = color.cgColor
        animatedLayer.lineWidth = lineWidth
        animatedLayer.strokeStart = 0.0
        animatedLayer.strokeEnd = 0.25
        animatedLayer.frame = bounds

        layer.addSublayer(animatedLayer)
    }

}

