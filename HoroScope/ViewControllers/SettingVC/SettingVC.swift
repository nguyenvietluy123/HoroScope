//
//  SettingVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class MenuObj: NSObject {
    var img: UIImage
    var title: String
    
    init(_ img: UIImage, title: String) {
        self.img = img
        self.title = title
    }
}

class SettingVC: UIViewController {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var arr: [MenuObj] = {
        let items: [MenuObj] = [MenuObj(#imageLiteral(resourceName: "setting_privatePolicy"), title: "Privacy Policy"),
                                MenuObj(#imageLiteral(resourceName: "setting_share"), title: "Share"),
                                MenuObj(#imageLiteral(resourceName: "setting_support"), title: "Support")]
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GCDCommon.mainQueue {
            SwiftyAd.shared.showBanner(from: self, at: .bottom)
        }
    }
    
}

extension SettingVC {
    func initUI() {
        tableView.register(CellSetting.self)
    }
}

extension SettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellSetting
        cell.config(menuObj: arr[indexPath.item])
        return cell
    }
}

extension SettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.item {
        case 0:
            let vc = Privacy_PolicyVC.init(nibName: "Privacy_PolicyVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            actionSupport()
            break
        case 2:
            actionShare()
            break
        default:
            Common.showAlert("Đang phát triển")
        }
    }
    
    func actionSupport() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tueanhoang.devios2011@gmail.com"])
            mail.setSubject("Regarding Weather Fake")
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func actionShare() {
        let text = [ "I found best application to Create Fake Weather Results... You must try too... Download Horoscope App Now... \nlink........" ]
        let activityViewController = UIActivityViewController(activityItems: text , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension SettingVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

//extension SettingVC: GADBannerViewDelegate {
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        bannerView.alpha = 0
//        UIView.animate(withDuration: 1, animations: {
//            bannerView.alpha = 1
//        })
//    }
//}
