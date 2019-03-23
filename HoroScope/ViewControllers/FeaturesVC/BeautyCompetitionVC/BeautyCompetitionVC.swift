//
//  CompetitionVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BeautyCompetitionVC: BaseVC {
    @IBOutlet weak var image1: KHImageView!
    @IBOutlet weak var image2: KHImageView!
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var lbDaddy: KHLabel!
    @IBOutlet weak var lbMommy: KHLabel!
//    @IBOutlet weak var compe_daddy: KHImageView!
    @IBOutlet weak var compe_cupid: KHView!
    @IBOutlet weak var compe_VS: UIView!
    
    var isBeautyPrediction: Bool = false
    var takeForImage1: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    @IBAction func action_image1(_ sender: Any) {
        openCamera()
        takeForImage1 = true
    }
    
    @IBAction func action_image2(_ sender: Any) {
        openCamera()
        takeForImage1 = false
    }
    
    @IBAction func action_Scan(_ sender: Any) {
        if image1.image != nil && image2.image != nil {
            let vc = ScanningVC.init(nibName: "ScanningVC", bundle: nil)
            vc.isBeautyPrediction = self.isBeautyPrediction
            vc.img1 = image1.image
            vc.img2 = image2.image
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Common.showAlert("Please take the face!")
        }
    }
}

extension BeautyCompetitionVC {
    func initUI() {
        navi.handleBack = {
            self.clickBack()
        }
        lbDaddy.text = isBeautyPrediction ? "Daddy" : "Miss 1"
        lbMommy.text = isBeautyPrediction ? "Mommy" : "Miss 2"
//        compe_daddy.image = isBeautyPrediction ? #imageLiteral(resourceName: "compe_daddy") : #imageLiteral(resourceName: "compe_mommy")
        compe_cupid.isHidden = !isBeautyPrediction
        compe_VS.isHidden = isBeautyPrediction
    }
}

extension BeautyCompetitionVC {
    override func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        if takeForImage1 {
            image1.image = croppedImage
        } else {
            image2.image = croppedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
