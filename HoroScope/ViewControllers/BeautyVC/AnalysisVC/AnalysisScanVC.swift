//
//  AnalysisScanVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/17/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class AnalysisScanVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var imgMain: KHImageView!
    
    var imgToScan: UIImage?
    var isDetect: Bool = true
    var rotation = CGAffineTransform()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

extension AnalysisScanVC {
    func initUI() {
//        rotateAnimation(imageView: imgMain, duration: 3)
        Common.addNotificationCenter(observer: self, selector: #selector(cantDetectFace), key: NotificationCenterKey.CantDetectFace)
        
        navi.handleBack = {
            self.clickBack()
        }
        self.imgMain.image = imgToScan
        scanFace()
    }
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        imageView.layer.add(rotateAnimation, forKey: nil)
    }
    
    func scanFace() {
        GCDCommon.mainQueueWithDelay(3) {
            ScanningVC.scan(imageScan: self.imgMain, wantDraw: false)
            if self.isDetect {
                GCDCommon.mainQueueWithDelay(1.5, {
                    let vc = AnalysisVC.init(nibName: "AnalysisVC", bundle: nil)
                    vc.imgToMark = self.imgMain.image
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }
    }
    
    @objc func cantDetectFace() {
        self.isDetect = false
        _ = AlertController.present(style: .alert, title: "Alert", message: "Can't detect face, Please try again!", actionTitles: ["Ok"], handler: { (action) in
            self.clickBack()
        })
    }
}

