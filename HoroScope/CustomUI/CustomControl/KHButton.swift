//
//  KHButton.swift
//  Design
//
//  Created by Hoa on 6/21/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

//@IBDesignable
class KHButton: UIButton {
    var indexPath: IndexPath?
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var numberOfLines: Int = 0 {
        didSet {
            self.titleLabel!.lineBreakMode = .byWordWrapping
            self.titleLabel!.textAlignment = .center
            self.titleLabel!.numberOfLines = numberOfLines
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
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            if shadow {
                layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                layer.shadowOpacity = 1.0
                layer.shadowRadius = 5.0
                layer.masksToBounds = false
            }
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        if circle {
            layer.cornerRadius = self.bounds.height/2
            layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let font = titleLabel?.font {
            titleLabel?.font = Common.getFontForDeviceWithFontDefault(fontDefault: font)
        }
    }
}


