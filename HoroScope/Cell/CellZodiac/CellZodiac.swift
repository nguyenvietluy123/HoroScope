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
    
    var handleCellForRow: ((CGFloat) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        viewContent.translatesAutoresizingMaskIntoConstraints = false
//        viewContent.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        viewContent.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        viewContent.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        viewContent.bottomAnchor.constraint(equalTo: lbDate.bottomAnchor, constant: 10).isActive = true
//        handleCellForRow?(viewContent.frame.height)
//        print(viewContent.frame.height)
    }
}

extension CellZodiac {
    func config(obj: ZodiacObj) {
        self.lbName.text = obj.name
        self.lbDate.text = obj.date
        self.imgView.image = obj.img
    }
}
