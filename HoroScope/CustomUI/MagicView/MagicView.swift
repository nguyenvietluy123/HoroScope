//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class MagicView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "MagicView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBInspectable var isGradient: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                ctr.constant = ctr.constant*heightRatio
            }
            
            if ctr.firstAttribute == .width {
                ctr.constant = ctr.constant*widthRatio
            }
            
            
        }
    }
    
    override func layoutSubviews() {
        if isGradient {
            GCDCommon.mainQueue {
                self.gradient(UIColor.init("FD9E74", alpha: 1), UIColor.init("FC1776", alpha: 1))
                self.isGradient = false
            }
        }
    }
    
    func gradient(_ firstColor: UIColor = UIColor.init("15EDED", alpha: 1.0), _ secondColor: UIColor = UIColor.init("029CF5", alpha: 1.0)){
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientLayer() {
        if let layers = self.layer.sublayers {
            for ly in layers {
                if ly is CAGradientLayer {
                    ly.removeFromSuperlayer()
                }
            }
        }
    }
 
}
