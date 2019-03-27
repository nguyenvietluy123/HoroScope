//
//  CellContent.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/23/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CellContent: UITableViewCell {
    @IBOutlet weak var lbContent: KHLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CellContent {
    func config(content: Content) {
        let attributeString = NSMutableAttributedString()
        
        if content.title != "" {
            attributeString.append(NSAttributedString(string: content.title + "\n\n", attributes: [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.boldSystemFont(ofSize: 18)), NSAttributedString.Key.foregroundColor : UIColor.red]))
        }
        attributeString.append(NSAttributedString(string: content.content + "\n", attributes: [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 17))]))
        
        self.lbContent.attributedText = attributeString
    }
}
