//
//  ViewController.swift
//  EarthAnimation
//
//  Created by Элина Рупова on 09.02.2022.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    
    @IBOutlet weak var earthView: UIView!
    @IBOutlet weak var earth: UIImageView!
    @IBOutlet weak var sun: UIImageView!
    var addSizeOfPath: CGFloat = 0.0
    let strEarthImages = ["earth1", "earth2", "earth3", "earth4", "earth5", "earth6", "earth7", "earth8", "earth9"]
    
    var roundShapeLayer: CAShapeLayer! {
        didSet {
            roundShapeLayer.lineWidth = 3
            roundShapeLayer.lineCap = .round
            roundShapeLayer.fillColor = nil
            roundShapeLayer.strokeEnd = 1
            roundShapeLayer.strokeColor = UIColor.white.cgColor
            roundShapeLayer.opacity = 0.2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSizeOfPath = view.bounds.maxX - sun.frame.size.width - 70
        roundShapeLayer = CAShapeLayer()
        view.layer.addSublayer(roundShapeLayer)
        addAnimation()
        addAnimationImagesOfEarth()
        self.view.bringSubviewToFront(earth)
        
    }
    
    override func viewDidLayoutSubviews() {
        roundShapeLayer.frame = view.bounds

        let path = UIBezierPath(roundedRect: CGRect(x: sun.frame.minX - (addSizeOfPath / 2), y: sun.frame.minY - (addSizeOfPath / 2), width: sun.frame.size.width + addSizeOfPath, height: sun.frame.size.height + addSizeOfPath), cornerRadius: (sun.frame.size.height + addSizeOfPath) / 2)
        roundShapeLayer.path = path.cgPath
    }
    
    func addAnimationImagesOfEarth() {
        var imagesOfEarth = [UIImage]()
        for i in 0...strEarthImages.count - 1 {
            let imageName = strEarthImages[i]
            let image = UIImage(named: imageName)
            imagesOfEarth.append(image!)
            self.earth.animationImages = imagesOfEarth
            self.earth.animationDuration = 2
            self.earth.startAnimating()
            
        }
    }
    
    func addAnimation() {

        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber(value: Double.pi * 2)
        animation.duration = 10
        animation.isCumulative = true
        animation.repeatCount = Float.greatestFiniteMagnitude
        earthView.layer.add(animation, forKey: nil)

    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        addAnimation()
    }
    
}

