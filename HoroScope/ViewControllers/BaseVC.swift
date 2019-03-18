//
//  BaseVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/16/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    var camera: CameraHelper? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension BaseVC {
    func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openCamera() {
        self.view.endEditing(true)
        if camera == nil {
            camera = CameraHelper(delegate_: self)
        }
        _ = UIAlertController.present(style: .actionSheet, title: "Select from:", message: nil, attributedActionTitles: [("Camera", .default), ("Library", .default), ("Cancel", .cancel)], handler: { (action) in
            
            if action.title == "Camera" {
                self.camera?.getCameraOn(self, canEdit: false)
            } else if action.title == "Library" {
                self.camera?.getPhotoLibraryOn(self, canEdit: false)
            }
        })
    }
}

extension BaseVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: false) {
                let imageCropVC = RSKImageCropViewController(image: pickedImage, cropMode: .circle)
                imageCropVC.delegate = self
                self.present(imageCropVC, animated: true, completion: nil)
            }
        }
    }
}

extension BaseVC : RSKImageCropViewControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
    }
}
