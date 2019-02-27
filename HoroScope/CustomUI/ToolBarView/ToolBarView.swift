//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class ToolBarView: UIView {
    @IBOutlet weak var viewStyleNotify: KHView!
    @IBOutlet weak var view3Button: KHView!
    @IBOutlet weak var btnNotifyLeft: KHButton!
    @IBOutlet weak var btnNotifyRight: KHButton!
    @IBOutlet weak var btnG3Left: KHButton!
    @IBOutlet weak var btnG3Center: KHButton!
    @IBOutlet weak var btnG3Right: KHButton!
    
    @IBInspectable open var titleNotifyLeft: String = "" {
        didSet {
            btnNotifyLeft.setTitle(titleNotifyLeft.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleNotifyRight: String = "" {
        didSet {
            btnNotifyRight.setTitle(titleNotifyRight.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG3Left: String = "" {
        didSet {
            btnG3Left.setTitle(titleG3Left.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG3Center: String = "" {
        didSet {
            btnG3Center.setTitle(titleG3Center.localized, for: .normal)
        }
    }
    
    @IBInspectable open var titleG3Right: String = "" {
        didSet {
            btnG3Right.setTitle(titleG3Right.localized, for: .normal)
        }
    }
    
    @IBInspectable open var style: Int = 1 {
        didSet {
            switch style {
            case 1:
                viewStyleNotify.isHidden = false
                view3Button.isHidden = true
                break
            case 2:
                viewStyleNotify.isHidden = true
                view3Button.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    @IBInspectable open var indexSelected: Int = 0 {
        didSet {
            switch style {
            case 1:
                if indexSelected == 0 {
                    btnNotifyLeft.setTitleColor(UIColor("323232", alpha: 1.0), for: .normal)
                    btnNotifyRight.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                } else {
                    btnNotifyLeft.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                    btnNotifyRight.setTitleColor(UIColor("323232", alpha: 1.0), for: .normal)
                }
                break
            case 2:
                if indexSelected == 0 {
                    btnG3Left.setTitleColor(UIColor("323232", alpha: 1.0), for: .normal)
                    btnG3Center.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                    btnG3Right.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                } else if indexSelected == 1 {
                    btnG3Left.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                    btnG3Center.setTitleColor(UIColor("323232", alpha: 1.0), for: .normal)
                    btnG3Right.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                } else {
                    btnG3Left.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                    btnG3Center.setTitleColor(UIColor("C4C4C4", alpha: 1.0), for: .normal)
                    btnG3Right.setTitleColor(UIColor("323232", alpha: 1.0), for: .normal)
                }
                break
            default:
                break
            }
        }
    }
    
    var handleButtonLeft: (() -> Void)?
    var handleButtonRight: (() -> Void)?
    var handleG3Left: (() -> Void)?
    var handleG3Center: (() -> Void)?
    var handleG3Right: (() -> Void)?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "ToolBarView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 80*1.4
                } else {
                    ctr.constant = 80*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
    }
    
    @IBAction func actionNotifyLeft(_ sender: Any) {
        indexSelected = 0
        handleButtonLeft?()
    }
    
    @IBAction func actionNotifyRight(_ sender: Any) {
        indexSelected = 1
        handleButtonRight?()
    }
    @IBAction func actionChooseLeft(_ sender: Any) {
        indexSelected = 0
        handleG3Left?()
    }
    
    @IBAction func actionChooseCenter(_ sender: Any) {
        indexSelected = 1
        handleG3Center?()
    }
    
    @IBAction func actionChooseRight(_ sender: Any) {
        indexSelected = 2
        handleG3Right?()
    }
}
