//
//  AssignToCell.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/26/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class CellSetting: UITableViewCell {
    @IBOutlet weak var lbName: KHLabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CellSetting {
    func config(menuObj: MenuObj) {
        self.lbName.text = menuObj.title
        self.img.image = menuObj.img
    }
}
