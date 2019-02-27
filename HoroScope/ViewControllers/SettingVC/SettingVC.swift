//
//  SettingVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class SettingVC: UIViewController {
//    @IBOutlet weak var navi: NavigationView!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var bannerView: GADBannerView!
    
    var arr: [String] = ["Favorite", "Privacy Policy", "Support", "Share"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initUI()
//        initAdmob()
    }
    
//    override func viewDidLayoutSubviews() {
//        Common.gradient(UIColor.init("ffa45f", alpha: 1.0), UIColor.init("ff8769", alpha: 1.0), view: self.view)
//    }
    
}

//extension SettingVC {
//    func initUI() {
//        tableView.register(CellHistory.self)
//    }
//    
//    func initAdmob() {
//        bannerView.adUnitID = kAdmobBanner
//        bannerView.rootViewController = self
//        bannerView.delegate = self
//        bannerView.load(GADRequest())
//    }
//}
//
//extension SettingVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellHistory
//        cell.lbName.text = "\(arr[indexPath.item])"
//        return cell
//    }
//    
//    
//}
//
//extension SettingVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55*heightRatio
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        switch indexPath.item {
//        case 0:
//            let vc = FavoriteVC.init(nibName: "FavoriteVC", bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
//            break
//        case 1:
//            let vc = Privacy_PolicyVC.init(nibName: "Privacy_PolicyVC", bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
//            break
//        case 2:
//            actionSupport()
//            break
//        case 3:
//            actionShare()
//            break
//        default:
//            Common.showAlert("Đang phát triển")
//        }
//    }
//    
//    func actionSupport() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["tueanhoang.devios2011@gmail.com"])
//            mail.setSubject("Regarding Weather Fake")
//            
//            present(mail, animated: true)
//        } else {
//            // show failure alert
//        }
//    }
//    
//    func actionShare() {
//        let text = [ "I found best application to Create Fake Weather Results... You must try too... Download Fake Weather App Now... \nlink........" ]
//        let activityViewController = UIActivityViewController(activityItems: text , applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
//    }
//}
//
//extension SettingVC: MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
//}
//
//extension SettingVC: GADBannerViewDelegate {
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        bannerView.alpha = 0
//        UIView.animate(withDuration: 1, animations: {
//            bannerView.alpha = 1
//        })
//    }
//}
