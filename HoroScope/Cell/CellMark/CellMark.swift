//
//  CellMark.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/17/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CellMark: UITableViewCell {
    @IBOutlet weak var imgMain: KHImageView!
    @IBOutlet weak var lbTitle: KHLabel!
    @IBOutlet weak var lbScoreLeft: KHLabel!
    @IBOutlet weak var lbScoreRight: KHLabel!
    @IBOutlet weak var viewScoreLeft: KHView!
    @IBOutlet weak var viewScoreRight: UIView!
    @IBOutlet weak var ctrViewScoreLeft: NSLayoutConstraint!
    @IBOutlet weak var ctrViewScoreRight: NSLayoutConstraint!
    @IBOutlet weak var viewCrownLeft: KHView!
    @IBOutlet weak var viewCrownRight: KHView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CellMark {
    func config(_ obj: MarkObj) {
        self.imgMain.image = obj.imgMain
        self.lbTitle.text = obj.title
        
        let roundedScoreLeft = Int((obj.scoreLeft*100).rounded(.up))
        let roundedScoreRight = Int((obj.scoreRight*100).rounded(.up))
        self.lbScoreLeft.text = "\(roundedScoreLeft)"
        self.lbScoreRight.text = "\(roundedScoreRight)"
        self.viewCrownLeft.isHidden = roundedScoreLeft < roundedScoreRight
        self.viewCrownRight.isHidden = roundedScoreLeft > roundedScoreRight
        createConstraint(ctr: ctrViewScoreLeft, multiCtr: CGFloat(roundedScoreLeft)/100)
        createConstraint(ctr: ctrViewScoreRight, multiCtr: CGFloat(roundedScoreRight)/100)
    }
    
    func createConstraint(ctr: NSLayoutConstraint, multiCtr: CGFloat) {
        let newConstraint = ctr.constraintWithMultiplier(multiCtr)
//        self.removeConstraint(ctr)
        self.addConstraint(newConstraint)
        self.layoutIfNeeded()
    }
}
