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
    @IBOutlet weak var imgBaby: KHImageView!
    @IBOutlet weak var frameBaby: UIImageView!
    @IBOutlet weak var viewTextBoy: KHView!
    @IBOutlet weak var viewTextGirl: KHView!
    @IBOutlet weak var viewBottom: UIView!
    
    var imgLeftTranfer: UIImage?
    var imgRightTranfer: UIImage?
    var arrboy: [String] = [ ]
    var arrgirl: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    @IBAction func action_Save(_ sender: Any) {
        viewBottom.isHidden = true
        Common.takeScreenshotAndSaveToLibrary()
        viewBottom.isHidden = false
    }
    
    @IBAction func action_Share(_ sender: Any) {
        viewBottom.isHidden = true
        Common.takeScreenshotAndShare(vc: self)
        viewBottom.isHidden = false
    }
}

extension BabyPredictionVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        imgLeft.image = imgLeftTranfer
        imgRight.image = imgRightTranfer
        
        let isBoy = randomBool()
        frameBaby.image = isBoy ? #imageLiteral(resourceName: "baby_boy") : #imageLiteral(resourceName: "baby_girl")
        viewTextBoy.isHidden = !isBoy
        viewTextGirl.isHidden = isBoy
        
        filterImage(isBoy: isBoy)
    }
    
    func filterImage(isBoy: Bool) {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            arrboy = items.filter({ (str) -> Bool in
                return str.contains("babyboy")
            })
            
            arrgirl = items.filter({ (str) -> Bool in
                return str.contains("babygirl")
            })
            
            if isBoy {
                if let image = UIImage(named: arrboy.randomElement() ?? "") {
                    imgBaby.image = image
                } else {
                    initUI()
                }
            } else {
                if let image = UIImage(named: arrgirl.randomElement() ?? "") {
                    imgBaby.image = image
                } else {
                    initUI()
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
}
