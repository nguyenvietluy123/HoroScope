//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    @IBOutlet weak var textField: KHTextField!
    
    @IBInspectable var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    @IBInspectable var isPass: Bool = false
    
    @IBInspectable open var padding: CGFloat = 0.0 {
        didSet {
            textField.padding = padding
        }
    }
    
    @IBInspectable open var text: String = "" {
        didSet {
            textField.text = text
            textOutput = text
        }
    }
    
    var textOutput: String = ""
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "TextFieldView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        textField.delegate = self
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 48*1.2
                } else {
                    ctr.constant = 48*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.textOutput = updatedText
        }
        if isPass {
            if string == " " {
                return false
            }
        }
        return true
    }
}
