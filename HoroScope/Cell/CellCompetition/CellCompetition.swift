//
//  CellCompetition.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/3/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CellCompetition: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CellCompetition {
    func config(_ obj: UIImage){
        self.imgView.image = obj
    }
}
