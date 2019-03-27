//
//  CompatibilityVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/23/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CompatibilityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var arrData: [UIImage] = [#imageLiteral(resourceName: "compa_love"), #imageLiteral(resourceName: "compa_zodiac")]
    var arrDataIpad: [UIImage] = [#imageLiteral(resourceName: "compa_love_ipad"), #imageLiteral(resourceName: "compa_zodiac_ipad")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SwiftyAd.shared.showBanner(from: self, at: .bottom)
    }
}

extension CompatibilityVC {
    func initUI() {
        tableView.register(CellCompetition.self)
    }
    
    func initData() {
        
    }
}

extension CompatibilityVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellCompetition
        cell.config(isIPad ? arrDataIpad[indexPath.item] : arrData[indexPath.item])
        return cell
    }
}

extension CompatibilityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.item {
        case 0:
            let vc = CompaLoveVC.init(nibName: "CompaLoveVC", bundle: nil)
            vc.isLoveCompatibility = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = CompaLoveVC.init(nibName: "CompaLoveVC", bundle: nil)
            vc.isLoveCompatibility = false
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
