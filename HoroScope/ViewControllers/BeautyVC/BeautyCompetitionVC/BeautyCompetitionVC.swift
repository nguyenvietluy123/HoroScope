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
        if image1.image != #imageLiteral(resourceName: "compe_user") && image2.image != #imageLiteral(resourceName: "compe_user") {
            let vc = ScanningVC.init(nibName: "ScanVC", bundle: nil)
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
    }
}

extension BeautyCompetitionVC {
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: false) {
                let imageCropVC = RSKImageCropViewController(image: pickedImage, cropMode: .circle)
                imageCropVC.delegate = self
                self.present(imageCropVC, animated: true, completion: nil)
            }
        }
    }
    
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
