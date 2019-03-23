//
//  File.swift
//  Welio
//
//  Created by Pham Khanh Hoa on 4/12/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let appleLanguages = "appleLanguages"

let TAppDelegate = UIApplication.shared.delegate as! AppDelegate

class Common {
    static func showAlert(_ strMessage: String){
        self.dismissAllAlert()
        let alert = AlertController(title: "Horoscope".localized, message: strMessage.localized, preferredStyle: UIAlertController.Style.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK".localized, style: .cancel) { action -> Void in
            
        }
        self.addNotificationCenter(observer: alert, selector: #selector(AlertController.hideAlertController), key: NotificationCenterKey.DismissAllAlert)
        alert.addAction(okAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func dismissAllAlert() {
        Common.postNotificationCenter(key: NotificationCenterKey.DismissAllAlert, object: nil)
    }
    
    class func getFontForDeviceWithFontDefault(fontDefault:UIFont) -> UIFont {
        var font:UIFont = fontDefault
        var sizeScale: CGFloat = 1
        if DeviceType.IS_IPAD {
            sizeScale = 1.3
        }else if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_7 {
            sizeScale = 0.95
        }else if DeviceType.IS_IPHONE_5 {
            sizeScale = 0.9
        }
        font = UIFont(name: font.fontName, size: font.pointSize * sizeScale)!
        return font
    }
    
    class func heightOfText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight
    }
    
    class func postNotificationCenter(key: String, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: key), object: object)
    }
    
    class func addNotificationCenter(observer: Any,selector: Selector, key: String) {
        removeNotificationCenter(observer: observer, key: key)
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: key), object: nil)
    }
    
    class func removeNotificationCenter(observer: Any, key: String) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: key), object: nil)
    }
    
    class func formatNumber(number : Int) -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value:number))!
    }
    
    class func viewNoData() -> UIView{
        if let window = UIApplication.shared.keyWindow {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: window.bounds.size.width, height: window.bounds.size.height))
            noDataLabel.text          = "txt_no_data".localized
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            let font = UIFont.init(name: "SFProDisplay-Regular", size: 16)
            noDataLabel.font = Common.getFontForDeviceWithFontDefault(fontDefault: font ?? UIFont.systemFont(ofSize: 16))
            return noDataLabel
        } else {
            return UIView()
        }
    }
    
    class func gradient(_ firstColor: UIColor = UIColor.init("ffa45f", alpha: 1.0), _ secondColor: UIColor = UIColor.init("ff8769", alpha: 1.0), view: UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    class func rotateImageAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0, followClockWise: Bool = true) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = followClockWise ? CGFloat(.pi * 2.0) : -CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        imageView.layer.add(rotateAnimation, forKey: nil)
    }
    
    class func addGradientAnimation(view: UIView, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0, 0, 0.1]
        gradientAnimation.toValue = [0.9, 1, 1.0]
        gradientAnimation.duration = 3
        gradientAnimation.autoreverses = true
        gradientAnimation.repeatCount = Float.infinity
        gradient.add(gradientAnimation, forKey: nil)
    }
    
    class func takeScreenshotAndSaveToLibrary() {
//        _ = AlertController.present(style: .alert, title: "HoroScope", message: "Do you want to take Screenshot and save to Library?", actionTitles: ["Cancel", "OK"], handler: { (action) in
//            if action.title == "OK" {
                let image = UIApplication.shared.screenShot
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                
                Common.showAlert("Took a screenshot")
//            }
//        })
    }
    
    class func takeScreenshotAndShare(vc: UIViewController) {
        let imageView = UIImageView()
        imageView.image = UIApplication.shared.screenShot
        //        let text = "This is the text...."
        let imageShare = [ imageView.image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = vc.view
        vc.present(activityViewController, animated: true, completion: nil)
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
