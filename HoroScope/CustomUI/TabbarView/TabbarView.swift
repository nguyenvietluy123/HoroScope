//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class TabbarView: UIView {
    @IBOutlet weak var imgHome: KHImageView!
    @IBOutlet weak var imgHistory: KHImageView!
    @IBOutlet weak var imgSetting: KHImageView!
    
    var handleHome: (() -> Void)?
    var handleHistory: (() -> Void)?
    var handleSetting: (() -> Void)?
    
    var indexSelected = 0 {
        didSet {
            switch indexSelected {
            case 0:
                imgHome.image = #imageLiteral(resourceName: "icon_home_selected")
                imgHistory.image = #imageLiteral(resourceName: "tab_history")
                imgSetting.image = #imageLiteral(resourceName: "tab_setting")
                break
            case 1:
                imgHome.image = #imageLiteral(resourceName: "tab_home")
                imgHistory.image = #imageLiteral(resourceName: "tab_history_selected")
                imgSetting.image = #imageLiteral(resourceName: "tab_setting")
                break
            case 2:
                imgHome.image = #imageLiteral(resourceName: "tab_home")
                imgHistory.image = #imageLiteral(resourceName: "tab_history")
                imgSetting.image = #imageLiteral(resourceName: "tab_setting_selected")
                break
            default:
                break
            }
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
        let xibFileName = "TabbarView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBAction func actionHome(_ sender: Any) {
        indexSelected = 0
        handleHome?()
    }
    
    @IBAction func actionHistory(_ sender: Any) {
        indexSelected = 1
        handleHistory?()
    }
    
    @IBAction func actionSetting(_ sender: Any) {
        indexSelected = 2
        handleSetting?()
    }
    
}
