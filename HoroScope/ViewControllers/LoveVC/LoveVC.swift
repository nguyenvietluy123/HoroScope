//
//  LoveVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/22/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoveVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewImgLeft: KHView!
    @IBOutlet weak var imgLeft: KHImageView!
    @IBOutlet weak var lbLeft: KHLabel!
    @IBOutlet weak var imgRight: KHImageView!
    @IBOutlet weak var lbRight: KHLabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var textView: KHTextView!
    
    var pointer = CGPoint()
    var leftHaveImg: Bool = false
    var rightHaveImg: Bool = false
    var isShowContentView: Bool = false
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
    var arrImg: [UIImage] = [#imageLiteral(resourceName: "Love_Aquarius"), #imageLiteral(resourceName: "Love_Pisces"), #imageLiteral(resourceName: "Love_Aries"), #imageLiteral(resourceName: "Love_Taurus"), #imageLiteral(resourceName: "Love_Gemini"), #imageLiteral(resourceName: "Love_Cancer"), #imageLiteral(resourceName: "Love_Leo"), #imageLiteral(resourceName: "Love_Virgo"), #imageLiteral(resourceName: "Love_Libra"), #imageLiteral(resourceName: "Love_Scorpio"), #imageLiteral(resourceName: "Love_Sagittarius"), #imageLiteral(resourceName: "Love_Capricorn")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

    @IBAction func btn_imgLeft(_ sender: Any) {
        guard isShowContentView != true else { return }
        leftHaveImg = false
        imgLeft.image = nil
        lbLeft.text = ""
    }
    
    @IBAction func btn_imgRight(_ sender: Any) {
        guard isShowContentView != true else { return }
        rightHaveImg = false
        imgRight.image = nil
        lbRight.text = ""
    }
    
    @IBAction func action_Check(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.viewContent.alpha = 1
        }
        isShowContentView = true
        
        if let path = Bundle.main.path(forResource: "aquarius", ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let json = JSON(parseJSON: jsonString)
                textView.text = json["content"].stringValue
                print(json)
            } catch {
                print("Can't read json file")
            }
        }
        
     
    }
    
    @IBAction func action_Done(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.viewContent.alpha = 0
        }
        isShowContentView = false
    }
    
    @objc func showCoor(sender: UITapGestureRecognizer) {
        pointer = sender.location(in: self.view)
    }
}

extension LoveVC {
    func initUI() {
        lbLeft.text = ""
        lbRight.text = ""
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCoor))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        viewContent.alpha = 0
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isIPad ? 140 : 100, right: 0)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isIPad ? 140 : 100, right: 0)
        collectionView.register(CellZodiac.self)
        collectionView.reloadData()
    }
    
    func initData() {
        
    }
}

extension LoveVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CellZodiac
        cell.config(obj: arrData[indexPath.item])
        return cell
    }
    
    
}

extension LoveVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CellZodiac {
            let imgView = UIImageView()
            imgView.frame = CGRect(x: pointer.x, y: pointer.y, width: cell.imgView.frame.width, height: cell.imgView.frame.height)
            imgView.image = cell.imgView.image
            self.view.addSubview(imgView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                var convertToWindow = CGRect()
                if self.leftHaveImg == false {
                    convertToWindow = self.imgLeft.convert(self.imgLeft.bounds, to: self.view)
                } else {
                    convertToWindow = self.imgRight.convert(self.imgRight.bounds, to: self.view)
                }
                imgView.frame = convertToWindow
                self.view.layoutIfNeeded()
            }) { (completed) in
                if self.leftHaveImg {
                    self.imgRight.image = self.arrImg[indexPath.item]
                    self.lbRight.text = self.arrData[indexPath.item].name
                } else {
                    self.imgLeft.image = self.arrImg[indexPath.item]
                    self.lbLeft.text = self.arrData[indexPath.item].name
                    self.leftHaveImg = true
                }
                UIView.animate(withDuration: 0.3, animations: {
                    imgView.alpha = 0
                }, completion: { (completed) in
                    imgView.removeFromSuperview()
                })
                
            }
        }
    }
}

extension LoveVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let attributeName = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.boldSystemFont(ofSize: 18))]
        let attributeDate = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 13))]
        
        let size = CGSize(width: ScreenSize.SCREEN_WIDTH/4, height: 1000)
        
        let estimatedLabelName = NSString(string: arrData[indexPath.item].name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeName, context: nil)
        let estimatedLabelDate = NSString(string: arrData[indexPath.item].date).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeDate, context: nil)
        
        return CGSize(width: size.width, height: size.width + estimatedLabelName.height + estimatedLabelDate.height + (isIPad ? 54 : 22))
    }
    
}
