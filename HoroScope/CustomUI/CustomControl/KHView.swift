//
//  KHView.swift
//  Design
//
//  Created by Hoa on 6/21/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

//@IBDesignable
class KHView: UIView {
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var isConstraint: Bool = false {
        didSet {
            if isConstraint {
                for ctr in self.constraints {
                    if ctr.firstAttribute == .height {
                        ctr.constant = (isIPad) ? ctr.constant*1.4 : ctr.constant*heightRatio
                    }
                }
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius * heightRatio
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            if shadow {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize.zero
                layer.shadowOpacity = 0.1
                layer.shadowRadius = 4.0
                layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var circle: Bool = false {
        didSet {
            if circle {
                layer.cornerRadius = self.bounds.height/2
                layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var isGradientColor: Bool = false {
        didSet {
            if isGradientColor {
                GCDCommon.mainQueue {
                    Common.gradient(self.minColor, self.maxColor, view: self)
                }
            }
        }
    }
    @IBInspectable public var minColor:UIColor = UIColor.blue
    @IBInspectable public var maxColor:UIColor = UIColor.orange
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        if circle {
            layer.cornerRadius = self.bounds.height/2
            layer.masksToBounds = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        initializeSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if circle {
            layer.cornerRadius = self.bounds.height/2
            layer.masksToBounds = true
        }
        
        if isGradientColor {
            GCDCommon.mainQueue {
                Common.gradient(self.minColor, self.maxColor, view: self)
            }
        }
    }
}
