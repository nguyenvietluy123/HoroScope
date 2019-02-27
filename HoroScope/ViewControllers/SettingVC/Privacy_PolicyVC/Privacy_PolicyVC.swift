//
//  Privacy_PolicyVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/21/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class Privacy_PolicyVC: UIViewController {
    @IBOutlet weak var navi: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navi.handleBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
