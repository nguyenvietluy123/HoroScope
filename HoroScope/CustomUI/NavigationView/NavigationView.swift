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
    }
    
    @IBAction func actionLeft(_ sender: Any) {
        handleBack?()
    }

}
