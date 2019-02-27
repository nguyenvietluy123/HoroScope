//
//  ZodiacsVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/25/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class ZodiacObj: NSObject {
    var name: String = ""
    var date: String = ""
    var img: UIImage = UIImage()
    
    override init() {
        super.init()
    }
    
    init(name: String, date: String, img: UIImage) {
        self.name = name
        self.date = date
        self.img = img
    }
}

class ZodiacsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrData: [ZodiacObj] = [ZodiacObj(name: Zodiac.Aquarius.rawValue, date:               ZodiacDate.Aquarius.rawValue, img: #imageLiteral(resourceName: "Aquarius")),
                                ZodiacObj(name: Zodiac.Pisces.rawValue, date: ZodiacDate.Pisces.rawValue, img: #imageLiteral(resourceName: "Pisces")),
                                ZodiacObj(name: Zodiac.Aries.rawValue, date: ZodiacDate.Aries.rawValue, img: #imageLiteral(resourceName: "Aries")),
                                ZodiacObj(name: Zodiac.Taurus.rawValue, date: ZodiacDate.Taurus.rawValue, img: #imageLiteral(resourceName: "Taurus")),
                                ZodiacObj(name: Zodiac.Gemini.rawValue, date: ZodiacDate.Gemini.rawValue, img: #imageLiteral(resourceName: "Gemini")),
                                ZodiacObj(name: Zodiac.Cancer.rawValue, date: ZodiacDate.Cancer.rawValue, img: #imageLiteral(resourceName: "Cancer")),
                                ZodiacObj(name: Zodiac.Leo.rawValue, date: ZodiacDate.Leo.rawValue, img: #imageLiteral(resourceName: "Leo")),
                                ZodiacObj(name: Zodiac.Virgo.rawValue, date: ZodiacDate.Virgo.rawValue, img: #imageLiteral(resourceName: "Virgo")),
                                ZodiacObj(name: Zodiac.Libra.rawValue, date: ZodiacDate.Libra.rawValue, img: #imageLiteral(resourceName: "Libra")),
                                ZodiacObj(name: Zodiac.Scorpio.rawValue, date: ZodiacDate.Scorpio.rawValue, img: #imageLiteral(resourceName: "Scorpio")),
                                ZodiacObj(name: Zodiac.Sagittarius.rawValue, date: ZodiacDate.Sagittarius.rawValue, img: #imageLiteral(resourceName: "Sagittarius")),
                                ZodiacObj(name: Zodiac.Capricorn.rawValue, date: ZodiacDate.Capricorn.rawValue, img: #imageLiteral(resourceName: "Capricorn"))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

}

extension ZodiacsVC {
    func initUI() {
        
        collectionView.register(CellZodiac.self)
    }
    
    func initData() {
        
    }
}

extension ZodiacsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CellZodiac
        cell.config(obj: arrData[indexPath.item])
        return cell
    }
}

extension ZodiacsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let attributeName = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.boldSystemFont(ofSize: 18))]
        let attributeDate = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 13))]
        
        let size = CGSize(width: ScreenSize.SCREEN_WIDTH/4, height: 1000)
        
        let estimatedLabelName = NSString(string: arrData[indexPath.item].name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeName, context: nil)
        let estimatedLabelDate = NSString(string: arrData[indexPath.item].date).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeDate, context: nil)
        
        return CGSize(width: size.width, height: size.width + estimatedLabelName.height + estimatedLabelDate.height + (isIPad ? 44 : 22))
    }
}
