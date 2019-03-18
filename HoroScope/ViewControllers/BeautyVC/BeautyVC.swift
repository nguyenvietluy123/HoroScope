//
//  CompetitionVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/22/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class BeautyVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!

    var arrData: [UIImage] = [#imageLiteral(resourceName: "competition_1st"), #imageLiteral(resourceName: "competiton_2nd"), #imageLiteral(resourceName: "competition_3rd")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
}

extension BeautyVC {
    func initUI() {
        tableView.register(CellCompetition.self)
    }
    
    func initData() {
        
    }
}

extension BeautyVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellCompetition
        cell.config(arrData[indexPath.item])
        return cell
    }
}

extension BeautyVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.item {
        case 0:
            openCamera()
            break
        case 1:
            let vc = BeautyCompetitionVC.init(nibName: "CompetitionVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}

extension BeautyVC {
    override func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }

    override func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        let vc = AnalysisScanVC.init(nibName: "AnalysisScanVC", bundle: nil)
        vc.imgToScan = croppedImage
        self.navigationController?.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
        
    }

    func imageCropViewController(_ controller: RSKImageCropViewController, willCropImage originalImage: UIImage) {

    }
}
