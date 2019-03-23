//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    @IBOutlet weak var lbTitleNav: KHLabel!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var imgLeft: UIImageView!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lbTitleNav.text = title.localized
        }
    }
    
    @IBInspectable open var hasLeft: Bool = false {
        didSet {
            viewLeft.isHidden = !hasLeft
        }
    }
    
    @IBInspectable open var hasCancel: Bool = false {
        didSet {
            imgLeft.image = hasCancel ? #imageLiteral(resourceName: "icon_delete") : #imageLiteral(resourceName: "navi_back")
        }
    }
    
    @IBInspectable open var isGradient: Bool = false {
        didSet {
            GCDCommon.mainQueue {
                if self.isGradient {
                    Common.gradient(self.firstColor, self.secondColor, view: self)
                }
            }
        }
    }
    @IBInspectable open var firstColor: UIColor = .clear
    @IBInspectable open var secondColor: UIColor = .clear
    
    var handleBack: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "NavigationView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 85
                } else if DeviceType.IS_IPHONE_X {
                    ctr.constant = 49 + UIApplication.shared.statusBarFrame.height
                } else {
                    ctr.constant = 69*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
        
        GCDCommon.mainQueue {
            if self.isGradient {
                Common.gradient(self.firstColor, self.secondColor, view: self)
            }
        }
    }
    
    @IBAction func actionLeft(_ sender: Any) {
        handleBack?()
    }

}
