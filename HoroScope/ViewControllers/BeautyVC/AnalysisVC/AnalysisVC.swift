//
//  AnalysisVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/13/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class AnalysisVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var lbScore: KHLabel!
    @IBOutlet weak var lbSkinStatus: KHLabel!
    @IBOutlet weak var lbExpression: KHLabel!
    @IBOutlet weak var lbBeautyLists: KHLabel!
    @IBOutlet weak var imgMain: KHImageView!
    @IBOutlet weak var ctrWidthToPoint: NSLayoutConstraint!
    
    let randomForPoint = Double.random(in: 0.5...0.95)
    var imgToMark: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
}

extension AnalysisVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        self.imgMain.image = imgToMark
        lbScore.text = "\((randomForPoint*100).rounded(toPlaces: 4))"
        createLabel()
        createPoint()
    }
    
    func createLabel() {
        let fontBlack = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 16))
        let fontOrange = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 20))
        let attributedText = NSMutableAttributedString(string: "Your beauty score defeated ", attributes: [NSAttributedString.Key.font : fontBlack, NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        
        let numberRounded = randomForPoint.rounded(toPlaces: 4)*100
        attributedText.append(NSAttributedString(string: "\(numberRounded)%", attributes: [NSAttributedString.Key.font : fontOrange, NSAttributedString.Key.foregroundColor : UIColor.init("FDB87D", alpha: 1)]))
        
        attributedText.append(NSAttributedString(string: " users from all over the world", attributes: [NSAttributedString.Key.font : fontBlack, NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
        
        lbBeautyLists.attributedText = attributedText
    }
    
    func createPoint() {
        print(randomForPoint)
        let newConstraint = self.ctrWidthToPoint.constraintWithMultiplier(CGFloat(randomForPoint))
        self.view!.removeConstraint(self.ctrWidthToPoint)
        self.view!.addConstraint(newConstraint)
        self.view!.layoutIfNeeded()
    }
}

