//
//  CellZodiac1.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/25/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CellZodiac: UICollectionViewCell {
    @IBOutlet weak var lbName: KHLabel!
    @IBOutlet weak var lbDate: KHLabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension CellZodiac {
    func config(obj: ZodiacObj) {
        self.lbName.text = obj.name
        self.lbDate.text = obj.date
        self.imgView.image = obj.img
    }
}
