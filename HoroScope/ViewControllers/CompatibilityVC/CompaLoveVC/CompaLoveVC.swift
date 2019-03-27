//
//  LoveVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/22/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompaLoveVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewImgLeft: KHView!
    @IBOutlet weak var imgLeft: KHImageView!
    @IBOutlet weak var lbLeft: KHLabel!
    @IBOutlet weak var imgRight: KHImageView!
    @IBOutlet weak var btnCheck: KHButton!
    @IBOutlet weak var lbRight: KHLabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var textView: KHTextView!
    @IBOutlet weak var viewButtonDone: KHView!
    @IBOutlet weak var viewButtonCheck: KHView!
    @IBOutlet weak var img_compaSound: KHImageView!
    @IBOutlet weak var img_compaHeart: KHImageView!
    
    var pointer = CGPoint()
    var isShowContentView: Bool = false
    var isLoveCompatibility: Bool = false
    var arrData: [ZodiacObj] = []
    var zodiacLeft: ZodiacObj = ZodiacObj()
    var zodiacRight: ZodiacObj = ZodiacObj()
    var arrImgLove: [UIImage] = [#imageLiteral(resourceName: "Love_Aquarius"), #imageLiteral(resourceName: "Love_Pisces"), #imageLiteral(resourceName: "Love_Aries"), #imageLiteral(resourceName: "Love_Taurus"), #imageLiteral(resourceName: "Love_Gemini"), #imageLiteral(resourceName: "Love_Cancer"), #imageLiteral(resourceName: "Love_Leo"), #imageLiteral(resourceName: "Love_Virgo"), #imageLiteral(resourceName: "Love_Libra"), #imageLiteral(resourceName: "Love_Scorpio"), #imageLiteral(resourceName: "Love_Sagittarius"), #imageLiteral(resourceName: "Love_Capricorn")]
    var arrIconZodiac: [UIImage] = [#imageLiteral(resourceName: "ic_aquarius"), #imageLiteral(resourceName: "ic_pisces"), #imageLiteral(resourceName: "ic_aries"), #imageLiteral(resourceName: "ic_taurus"), #imageLiteral(resourceName: "ic_gemini"), #imageLiteral(resourceName: "ic_cancer"), #imageLiteral(resourceName: "ic_leo"), #imageLiteral(resourceName: "ic_virgo"), #imageLiteral(resourceName: "ic_libra"), #imageLiteral(resourceName: "ic_scorpio"), #imageLiteral(resourceName: "ic_sagittarius"), #imageLiteral(resourceName: "ic_capricorn")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

    @IBAction func btn_imgLeft(_ sender: Any) {
        guard isShowContentView != true else { return }
        zodiacLeft = ZodiacObj()
        imgLeft.image = #imageLiteral(resourceName: "compa_questionMark")
        lbLeft.text = ""
    }
    
    @IBAction func btn_imgRight(_ sender: Any) {
        guard isShowContentView != true else { return }
        zodiacRight = ZodiacObj()
        imgRight.image = #imageLiteral(resourceName: "compa_questionMark")
        lbRight.text = ""
    }
    
    @IBAction func action_Check(_ sender: Any) {
        guard zodiacLeft.name != "" && zodiacRight.name != "" else {
            Common.showAlert("Please choose Zodiac")
            return
        }
        SwiftyAd.shared.delegate = self
        SwiftyAd.shared.showInterstitial(from: self)
        //show content when did close Admob, at delegate protocol
    }
    
    @IBAction func action_Done(_ sender: Any) {
        GCDCommon.mainQueue {
            self.tabBarController?.setTabBarVisible(visible: true, duration: 0.15, animated: true)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.viewContent.alpha = 0
            self.collectionView.alpha = 1
            self.viewButtonCheck.alpha = 1
            self.viewButtonDone.alpha = 2
        })
        isShowContentView = false
    }
    
    @objc func showCoor(sender: UITapGestureRecognizer) {
        pointer = sender.location(in: self.view)
    }
    
    func showContent() {
        GCDCommon.mainQueue {
            self.tabBarController?.setTabBarVisible(visible: false, duration: 0.2, animated: true)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.viewContent.alpha = 1
            self.collectionView.alpha = 0
            self.viewButtonCheck.alpha = 0
            self.viewButtonDone.alpha = 1
        })
        isShowContentView = true
        
        readJsonShared.checkLove(resource: (isLoveCompatibility ? "" : "old_") + "\(zodiacLeft.name.lowercased())_\(zodiacRight.name.lowercased())") { (str) in
            self.textView.setContentOffset(.zero, animated: false)
            self.textView.text = str
        }
    }
}

extension CompaLoveVC {
    func initUI() {
        navi.title = isLoveCompatibility ? "Love Compatibility" : "Zodiac Compatibility"
        navi.handleBack = {
            self.clickBack()
            self.tabBarController?.setTabBarVisible(visible: true, duration: 0.15, animated: true)
        }
        
        lbLeft.text = ""
        lbRight.text = ""
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCoor))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        viewContent.alpha = 0
        img_compaHeart.isHidden = !isLoveCompatibility
        img_compaSound.isHidden = isLoveCompatibility
//        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isIPad ? 80 : 60, right: 0)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isIPad ? 75 : 55, right: 0)
        collectionView.register(CellZodiac.self)
        collectionView.reloadData()
    }
    
    func initData() {
        arrData = [ZodiacObj(name: Zodiac.Aquarius.rawValue, date:               ZodiacDate.Aquarius.rawValue, img: #imageLiteral(resourceName: "Aquarius")),
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
    }
}

extension CompaLoveVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CellZodiac
        cell.config(obj: arrData[indexPath.item])
        if isLoveCompatibility == false {
            cell.imgView.image = arrImgLove[indexPath.item]
        }
        return cell
    }
    
    
}

extension CompaLoveVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CellZodiac {
            let imgView = UIImageView()
            imgView.frame = CGRect(x: pointer.x, y: pointer.y, width: cell.imgView.frame.width, height: cell.imgView.frame.height)
            imgView.image = cell.imgView.image
            self.view.addSubview(imgView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                var convertToWindow = CGRect()
                if self.zodiacLeft.name == "" {
                    convertToWindow = self.imgLeft.convert(self.imgLeft.bounds, to: self.view)
                } else {
                    convertToWindow = self.imgRight.convert(self.imgRight.bounds, to: self.view)
                }
                imgView.frame = convertToWindow
                self.view.layoutIfNeeded()
            }) { (completed) in
                if self.zodiacLeft.name != ""  {
                    self.imgRight.image = self.isLoveCompatibility ? self.arrIconZodiac[indexPath.item] : self.arrImgLove[indexPath.item]
                    self.zodiacRight = self.arrData[indexPath.item]
                    self.lbRight.text = self.arrData[indexPath.item].name
                } else {
                    self.imgLeft.image = self.isLoveCompatibility ?self.arrIconZodiac[indexPath.item] : self.arrImgLove[indexPath.item]
                    self.zodiacLeft = self.arrData[indexPath.item]
                    self.lbLeft.text = self.arrData[indexPath.item].name
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

extension CompaLoveVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let attributeName = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.boldSystemFont(ofSize: 18))]
        let attributeDate = [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 13))]
        
        let size = CGSize(width: ScreenSize.SCREEN_WIDTH/3.4, height: 1000)
        
        let estimatedLabelName = NSString(string: arrData[indexPath.item].name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeName, context: nil)
        let estimatedLabelDate = NSString(string: arrData[indexPath.item].date).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeDate, context: nil)
        
        return CGSize(width: size.width, height: size.width + estimatedLabelName.height + estimatedLabelDate.height + (isIPad ? 54 : 22))
    }
    
}

extension UITabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            }.startAnimation()
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}

extension CompaLoveVC: SwiftyAdDelegate {
    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
        
    }
    
    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
        showContent()
    }
    
    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
        
    }
}
