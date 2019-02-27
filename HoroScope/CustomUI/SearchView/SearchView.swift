//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class SearchView: UIView {
    @IBOutlet weak var tfSearch: KHTextField!
//    @IBOutlet weak var ctrTrailingView: NSLayoutConstraint!
//    @IBOutlet weak var viewScan: UIView!
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            tfSearch.placeholder = placeholder
        }
    }
    
    var handleSearchLocal: ((String) -> Void)?
    var handleSearchAPI: ((String) -> Void)?
    var handleEndEditing: (() -> Void)?
    var handleReturn: (() -> Void)?
    var isSearchMap = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 85
                } else {
                    ctr.constant = 70*heightRatio
                }
            }
        }
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        self.endEditing(true)
        handleSearchAPI?(tfSearch.text ?? "")
    }
}

extension SearchView {
    func initializeSubviews() {
        let xibFileName = "SearchView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        tfSearch.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        handleSearchLocal?(tfSearch.text?.trim() ?? "")
    }
    
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfSearch.text = textField.text?.trim()
        if !isSearchMap {
            handleSearchAPI?(tfSearch.text ?? "")
            handleSearchLocal?(tfSearch.text!.trim())
        }
        handleReturn?()
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.endEditing(true)
        handleEndEditing?()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isSearchMap {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
    
}
