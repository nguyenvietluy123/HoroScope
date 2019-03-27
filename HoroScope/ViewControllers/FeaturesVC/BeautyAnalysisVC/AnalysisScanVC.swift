//
//  AnalysisScanVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/17/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

var timeDelay: Double = 1

class AnalysisScanVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var imgMain: KHImageView!
    @IBOutlet weak var scanOrangeIn: KHImageView!
    @IBOutlet weak var scanOrangeOut: KHImageView!
    @IBOutlet weak var lbProgress: KHLabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lbStatus: KHLabel!
    
    var imgToScan: UIImage?
    var isDetect: Bool = true
    var timer: Timer = Timer()
    var rotation = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Common.removeNotificationCenter(observer: self, key: NotificationCenterKey.CantDetectFace)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.progressView.layer.cornerRadius = self.progressView.frame.height/2
        progressView.clipsToBounds = true
    }
}

extension AnalysisScanVC {
    func initUI() {
        navi.handleBack = {
            self.clickBack()
        }
        self.imgMain.image = imgToScan
        Common.rotateImageAnimation(imageView: scanOrangeOut, duration: 4, followClockWise: true)
        Common.rotateImageAnimation(imageView: scanOrangeIn, duration: 4, followClockWise: false)
        GCDCommon.mainQueue {
            Common.addGradientAnimation(view: self.imgMain, colors: [UIColor.clear.cgColor, UIColor.init("ffa31f", alpha: 1).cgColor, UIColor.clear.cgColor])
        }
        let gradientImage = UIImage.gradientImage(with: progressView.frame,
                                                  colors: [UIColor.init("FFA459", alpha: 1).cgColor,
                                                           UIColor.init("E53330", alpha: 1).cgColor],
                                                  locations: nil)
        progressView.progressImage = gradientImage!
        
        startProgress()
        
        Common.addNotificationCenter(observer: self, selector: #selector(cantDetectFace), key: NotificationCenterKey.CantDetectFace)
    }
    
    func startProgress() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { (timer) in
            if self.progressView.progress < 0.8 {
                self.progressTo_80()
            } else {
                self.progressWhenCompleted()
            }
            self.lbProgress.text = "\(Int(self.progressView.progress*100))%"
        })
        timer.fire()
    }
    
    func progressTo_80 () {
        UIView.animate(withDuration: 0.5, delay: 0, options:
            UIView.AnimationOptions.curveEaseOut, animations: {
                self.progressView.setProgress(self.progressView.progress + 0.01, animated: true)
        }, completion: nil)
    }
    
    func progressWhenCompleted() {
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            ScanningVC.shared.scan(imageScan: self.imgMain, wantDraw: true)
            self.timer.invalidate()
            if self.isDetect {
                self.progressView.setProgress(1, animated: true)
                self.lbStatus.text = "Analysing..."
            }
        }, completion: { (completed) in
            if self.isDetect {
                SwiftyAd.shared.delegate = self
                SwiftyAd.shared.showInterstitial(from: self)
            }
        })
    }
    
    func scanFace() {
        
        GCDCommon.mainQueueWithDelay(3) {
            
        }
    }
    
    @objc func cantDetectFace() {
        self.isDetect = false
        _ = AlertController.present(style: .alert, title: "Alert", message: "Can't detect face, Please try again!", actionTitles: ["Ok"], handler: { (action) in
            self.clickBack()
        })
    }
}

extension AnalysisScanVC: SwiftyAdDelegate {
    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
        GCDCommon.mainQueueWithDelay(timeDelay, {
            let vc = AnalysisVC.init(nibName: "AnalysisVC", bundle: nil)
            vc.imgToMark = self.imgToScan
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
        
    }
    
    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
        
    }
}
