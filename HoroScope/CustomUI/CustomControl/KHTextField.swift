//
//  WTextField.swift
//  Welio
//
//  Created by Hoa on 6/21/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit
private var kAssociationKeyMaxLength: Int = 0
//@IBDesignable
class KHTextField: UITextField {
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
    
    @IBInspectable var placeHolderColor: UIColor = .gray {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder!.localized : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var padding: CGFloat = 0.0 {
        didSet {
            if padding > 0 {
                let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: frame.size.height))
                leftView = paddingView
                leftViewMode = .always
            }
        }
    }
    
    @IBInspectable var isCurrency: Bool = false
    var handleText: ((String) -> Void)?
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        if isCurrency {
            self.text = self.text?.currency()
        }
        handleText?(text ?? "")
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText[..<maxCharIndex])
        selectedTextRange = selection
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder!.localized : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        self.autocorrectionType = .no
        if let realFont = font {
            font = Common.getFontForDeviceWithFontDefault(fontDefault: realFont)
        }
//        if DeviceType.IS_IPHONE {
//            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50))
//            doneToolbar.barStyle = UIBarStyle.default
//            
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//            let done = UIBarButtonItem(title: "Ẩn", style: .done, target: self, action: #selector(doneButtonAction))
//            done.tintColor = TColor.pinkColor
//            let items = NSMutableArray()
//            items.add(flexSpace)
//            items.add(done)
//            
//            doneToolbar.items = items as? [UIBarButtonItem]
//            doneToolbar.sizeToFit()
//            
//            self.inputAccessoryView = doneToolbar
//        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder!.localized : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        self.autocorrectionType = .no
        layoutIfNeeded()
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
