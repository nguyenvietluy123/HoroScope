//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    @IBOutlet weak var viewStyleLogin: UIView!
    @IBOutlet weak var viewStyleRegister: UIView!
    @IBOutlet weak var viewStyleFilter: UIView!
    @IBOutlet weak var viewStyleCheckIn: UIView!
    @IBOutlet weak var buttonStyleLogin: KHButton!
    @IBOutlet weak var buttonStyleRegister: KHButton!
    @IBOutlet weak var btnStyleFilterLeft: KHButton!
    @IBOutlet weak var btnStyleFilterRight: KHButton!
    @IBOutlet weak var btnCheckIn: KHButton!
    
    @IBInspectable open var titleStyleLogin: String = "" {
        didSet {
            buttonStyleLogin.setTitle(titleStyleLogin.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG2LeftStyleRegister: String = "" {
        didSet {
            buttonStyleRegister.setTitle(titleG2LeftStyleRegister.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG2LeftStyleFilter: String = "" {
        didSet {
            buttonStyleRegister.setTitle(titleG2LeftStyleFilter.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG2RightStyleFilter: String = "" {
        didSet {
            buttonStyleRegister.setTitle(titleG2RightStyleFilter.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleStyleCheckIn: String = "" {
        didSet {
            btnCheckIn.setTitle(titleStyleCheckIn.localized, for: .normal)
        }
    }
    
    @IBInspectable open var style: Int = 1 {
        didSet {
            switch style {
            case 1:
                viewStyleLogin.isHidden = false
                viewStyleRegister.isHidden = true
                viewStyleFilter.isHidden = true
                viewStyleCheckIn.isHidden = true
                break
            case 2:
                viewStyleLogin.isHidden = true
                viewStyleRegister.isHidden = false
                viewStyleFilter.isHidden = true
                viewStyleCheckIn.isHidden = true
                break
            case 3:
                viewStyleLogin.isHidden = true
                viewStyleRegister.isHidden = true
                viewStyleFilter.isHidden = false
                viewStyleCheckIn.isHidden = true
                break
            case 4:
                viewStyleLogin.isHidden = true
                viewStyleRegister.isHidden = true
                viewStyleFilter.isHidden = true
                viewStyleCheckIn.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    var handleStyleLoginAction: (() -> Void)?
    var handleStyleRegisterAction: (() -> Void)?
    var handleStyleFilterLeft: (() -> Void)?
    var handleStyleFilterRight: (() -> Void)?
    var handleStyleCheckIn: (() -> Void)?
    var handleNotifyLeft: (() -> Void)?
    var handleNotifyRight: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "ButtonView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height && ctr.constant > 0 {
                if DeviceType.IS_IPAD {
                    ctr.constant = 80*1.2
                } else {
                    ctr.constant = 80*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
    }
    
    
    @IBAction func actionStyleLogin(_ sender: Any) {
        handleStyleLoginAction?()
    }
    
    @IBAction func actionStyleRegister(_ sender: Any) {
        handleStyleRegisterAction?()
    }
    
    @IBAction func actionStyleFilterLeft(_ sender: Any) {
        handleStyleFilterLeft?()
    }
    
    @IBAction func actionStyleFilterRight(_ sender: Any) {
        handleStyleFilterRight?()
    }
    
    @IBAction func actionStyleCheckin(_ sender: Any) {
        handleStyleCheckIn?()
    }

}
