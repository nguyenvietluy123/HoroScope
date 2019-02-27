//
//  AlertHelper.swift
//  Task
//
//  Created by Hoa on 3/31/18.
//  Copyright © 2018 SDC. All rights reserved.
//

import UIKit

public typealias ActionHandler = (_ action: UIAlertAction) -> ()
public typealias AttributedActionTitle = (title: String, style: UIAlertAction.Style)

class AlertController: UIAlertController {
    @objc
    func hideAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
}

public extension UIAlertController {
    
    public class func present(style: UIAlertController.Style = .alert, title: String?, message: String?, actionTitles: [String]?, handler: ActionHandler? = nil) -> UIAlertController {
        let rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        return self.presentFromViewController(viewController: rootViewController, style: style, title: title, message: message, actionTitles: actionTitles, handler: handler)
    }
    
    public class func present(style: UIAlertController.Style = .alert, title: String?, message: String?, attributedActionTitles: [AttributedActionTitle]?, handler: ActionHandler? = nil) -> UIAlertController {
        let rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        return self.presentFromViewController(viewController: rootViewController, style: style, title: title, message: message, attributedActionTitles: attributedActionTitles, handler: handler)
    }
    
    public class func presentFromViewController(viewController: UIViewController, style: UIAlertController.Style = .alert, title: String?, message: String?, actionTitles: [String]?, handler: ActionHandler? = nil) -> UIAlertController {
        return self.presentFromViewController(viewController: viewController, style: style, title: title, message: message, attributedActionTitles: actionTitles?.map({ (title) -> AttributedActionTitle in return (title: title, style: .default) }), handler: handler)
    }
    
    public class func presentFromViewController(viewController: UIViewController, style: UIAlertController.Style = .alert, title: String?, message: String?, attributedActionTitles: [AttributedActionTitle]?, handler: ActionHandler? = nil) -> UIAlertController {
        let alertController = AlertController(title: title?.localized, message: message?.localized, preferredStyle: style)
        if let _attributedActionTitles = attributedActionTitles {
            for _attributedActionTitle in _attributedActionTitles {
                let buttonAction = UIAlertAction(title: _attributedActionTitle.title, style: _attributedActionTitle.style, handler: { (action) -> Void in
                    handler?(action)
                })
                alertController.addAction(buttonAction)
            }
        }
        NotificationCenter.default.addObserver(alertController, selector: #selector(AlertController.hideAlertController), name: NSNotification.Name(rawValue: NotificationCenterKey.DismissAllAlert), object: nil)
        
        if DeviceType.IS_IPAD {
            alertController.popoverPresentationController?.sourceView = viewController.view
            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            alertController.popoverPresentationController?.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            viewController.present(alertController, animated: true) {
                print("option menu presented")
            }
        } else {
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
        return alertController
    }
}

// MARK:
public extension UIViewController {
    public func presentAlert(style: UIAlertController.Style = .alert, title: String?, message: String?, actionTitles: [String]?, handler: ActionHandler? = nil) -> UIAlertController {
        return UIAlertController.presentFromViewController(viewController: self, style: style, title: title, message: message, actionTitles: actionTitles, handler: handler)
    }
    
    public func presentAlert(style: UIAlertController.Style = .alert, title: String?, message: String?, attributedActionTitles: [AttributedActionTitle]?, handler: ActionHandler? = nil) -> UIAlertController {
        return UIAlertController.presentFromViewController(viewController: self, style: style, title: title, message: message, attributedActionTitles: attributedActionTitles, handler: handler)
    }
    
    var topPresentedViewController: UIViewController? {
        get {
            var target: UIViewController? = self
            while (target?.presentedViewController != nil) {
                target = target?.presentedViewController
            }
            return target
        }
    }
    
    var topVisibleViewController: UIViewController? {
        get {
            if let nav = self as? UINavigationController {
                return nav.topViewController?.topVisibleViewController
            }
            else if let tabBar = self as? UITabBarController {
                return tabBar.selectedViewController?.topVisibleViewController
            }
            return self
        }
    }
    
    var topMostViewController: UIViewController? {
        get {
            return self.topPresentedViewController?.topVisibleViewController
        }
    }
}
