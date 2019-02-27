//
//  InputView.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//


import UIKit

class InputView: UIView {
    @IBOutlet weak var lbTitle: KHLabel!
    @IBOutlet weak var tfValue: KHTextField!
    @IBOutlet weak var viewInput: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "InputView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        GCDCommon.mainQueue {
//            self.lbTitle.roundCorners(corners: [.topLeft, .bottomLeft], radius: DeviceType.IS_IPAD ? 18 : 10)
//            self.tfValue.roundCorners(corners: [.topRight, .bottomRight], radius: DeviceType.IS_IPAD ? 18 : 10)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
