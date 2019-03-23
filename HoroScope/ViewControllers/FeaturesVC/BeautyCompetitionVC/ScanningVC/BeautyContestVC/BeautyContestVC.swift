//
//  MarkVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/17/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BeautyContestVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgLeft: KHImageView!
    @IBOutlet weak var imgRight: KHImageView!
    @IBOutlet weak var lbScoreLeft: KHLabel!
    @IBOutlet weak var lbScoreRight: KHLabel!
    @IBOutlet weak var winLeft: UIImageView!
    @IBOutlet weak var crownLeft: UIImageView!
    @IBOutlet weak var winRight: UIImageView!
    @IBOutlet weak var crownRight: UIImageView!
    @IBOutlet weak var viewBottom: UIView!
    
    var arrMark: [MarkObj] = []
    var imgLeftTranfer: UIImage?
    var imgRightTranfer: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

    @IBAction func action_Save(_ sender: Any) {
        viewBottom.isHidden = true
        Common.takeScreenshotAndSaveToLibrary()
        viewBottom.isHidden = false
    }
    
    @IBAction func action_Share(_ sender: Any) {
        viewBottom.isHidden = true
        Common.takeScreenshotAndShare(vc: self)
        viewBottom.isHidden = false
    }
}

extension BeautyContestVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        imgLeft.image = imgLeftTranfer
        imgRight.image = imgRightTranfer
        tableView.register(CellMark.self)
    }
    
    func initData() {
        var obj = MarkObj(title: "Eyes", imgMain: #imageLiteral(resourceName: "compe_eyes"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
        arrMark.append(obj)
        obj = MarkObj(title: "Nose", imgMain: #imageLiteral(resourceName: "compe_nose"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
        arrMark.append(obj)
        obj = MarkObj(title: "Mouth", imgMain: #imageLiteral(resourceName: "compe_mouth"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
        arrMark.append(obj)
        obj = MarkObj(title: "Smile", imgMain: #imageLiteral(resourceName: "compe_smile"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
        arrMark.append(obj)
        obj = MarkObj(title: "Skin", imgMain: #imageLiteral(resourceName: "compe_skin"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
        arrMark.append(obj)
//        obj = MarkObj(title: "Expression", imgMain: #imageLiteral(resourceName: "mark_eye"), scoreLeft: Double.random(in: 0.5...1), scoreRight: Double.random(in: 0.5...1))
//        arrMark.append(obj)
        
        var totalScoreLeft: Double = 0
        var totalScoreRight: Double = 0
        for i in arrMark.indices {
            totalScoreLeft += (arrMark[i].scoreLeft*100).rounded(.up)
            totalScoreRight += (arrMark[i].scoreRight*100).rounded(.up)
        }
        lbScoreLeft.text = "\(Int(totalScoreLeft/6))"
        lbScoreRight.text = "\(Int(totalScoreRight/6))"
        winLeft.isHidden = totalScoreLeft < totalScoreRight
        crownLeft.isHidden = totalScoreLeft < totalScoreRight
        winRight.isHidden = totalScoreLeft > totalScoreRight
        crownRight.isHidden = totalScoreLeft > totalScoreRight
    }
}

extension BeautyContestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellMark
        cell.config(arrMark[indexPath.item])
        return cell
    }
    
    
}

extension BeautyContestVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
//        return 60*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
