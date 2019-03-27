//
//  BeautyAnalysisVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/20/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BeautyAnalysisVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var imgMain: KHImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func openCamera(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func action_Scan(_ sender: Any) {
        if imgMain.image != #imageLiteral(resourceName: "compe_defaultBoy") {
            let vc = AnalysisScanVC.init(nibName: "AnalysisScanVC", bundle: nil)
            vc.imgToScan = imgMain.image
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Common.showAlert("Please take the face!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GCDCommon.mainQueue {
            self.tabBarController?.tabBar.isHidden = true
        }
        SwiftyAd.shared.showBanner(from: self, at: .bottom)
    }
}

extension BeautyAnalysisVC {
    func initUI() {
        navi.handleBack = {
            self.clickBack()
        }
    }
}

extension BeautyAnalysisVC {
    override func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        self.imgMain.image = croppedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, willCropImage originalImage: UIImage) {
        
    }
}

