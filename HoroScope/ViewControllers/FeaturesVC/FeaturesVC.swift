//
//  CompetitionVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/22/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class FeaturesVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!

    var arrData: [UIImage] = [#imageLiteral(resourceName: "competition_1st"), #imageLiteral(resourceName: "competiton_2nd"), #imageLiteral(resourceName: "competition_3rd")]
    var arrDataIpad: [UIImage] = [#imageLiteral(resourceName: "competition_1st_ipad"), #imageLiteral(resourceName: "competiton_2nd_ipad"), #imageLiteral(resourceName: "competition_3rd_ipad")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GCDCommon.mainQueue {
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.setTabBarVisible(visible: true, duration: 0.15, animated: true)
        }
        SwiftyAd.shared.showBanner(from: self, at: .bottom)
    }
}

extension FeaturesVC {
    func initUI() {
        tableView.register(CellCompetition.self)
    }
    
    func initData() {
        
    }
}

extension FeaturesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellCompetition
        cell.config(isIPad ? arrDataIpad[indexPath.item] : arrData[indexPath.item])
        return cell
    }
}

extension FeaturesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        GCDCommon.mainQueue {
            self.tabBarController?.setTabBarVisible(visible: false, duration: 0.2, animated: true)
        }
        switch indexPath.item {
        case 0:
            let vc = BeautyAnalysisVC.init(nibName: "BeautyAnalysisVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = BeautyCompetitionVC.init(nibName: "BeautyCompetitionVC", bundle: nil)
            vc.isBeautyPrediction = false
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = BeautyCompetitionVC.init(nibName: "BeautyCompetitionVC", bundle: nil)
            vc.isBeautyPrediction = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
