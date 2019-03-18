//
//  BabyPredictionVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/18/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BabyPredictionVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var imgLeft: KHImageView!
    @IBOutlet weak var imgRight: KHImageView!
    
    var imgLeftTranfer: UIImage?
    var imgRightTranfer: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

extension BabyPredictionVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        imgLeft.image = imgLeftTranfer
        imgLeft.image = imgLeftTranfer
    }
}
