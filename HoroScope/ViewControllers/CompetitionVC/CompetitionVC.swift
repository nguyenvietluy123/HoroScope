//
//  CompetitionVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/22/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CompetitionVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var arrData: [UIImage] = [#imageLiteral(resourceName: "competition_1st"), #imageLiteral(resourceName: "competiton_2nd"), #imageLiteral(resourceName: "competition_3rd")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
}

extension CompetitionVC {
    func initUI() {
        tableView.register(CellCompetition.self)
    }
    
    func initData() {
        
    }
}

extension CompetitionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellCompetition
        cell.config(arrData[indexPath.item])
        return cell
    }
}

extension CompetitionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            addCameraView()
            break
        default:
            break
        }
    }
    
    func addCameraView() {
        let cameraView = CameraView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT))
        cameraView.backgroundColor = .yellow
        hideTabbar(true)
        self.view.addSubview(cameraView)
    }
    
    func hideTabbar(_ hide: Bool) {
        if hide {
            TAppDelegate.tabVC?.tabBar.isHidden = true
            TAppDelegate.tabVC?.tabBar.isTranslucent = true
        } else {
            TAppDelegate.tabVC?.tabBar.isHidden = false
            TAppDelegate.tabVC?.tabBar.isTranslucent = false
        }
    }
}
